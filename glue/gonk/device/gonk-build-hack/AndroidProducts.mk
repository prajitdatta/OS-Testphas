# This file is here for hacking Android's build system.
# AndroidProducts.mk would be loaded by product.mk and
# product_config.mk, envsetup.mk and config.mk in turn.
# It is loaded after definition of BUILD_XXX variables.
# We can override BUILD_XXX here.
#
GONK_BUILD_HACK:=$(TOPDIR)device/gonk-build-hack

# Wrap droiddoc.mk.
#
# droiddoc.mk is a special case.  It does not create new modules.
# So, we can not learn it without wrap it.
#
BUILD_DROIDDOC:= $(GONK_BUILD_HACK)/droiddoc-noop.mk

# Force make to stop building prerequistes of apicheck.  apicheck
# invoke a java tool to check API version.  We delete it to prevent
# from being loaded.
$(shell rm -f $(TOPDIR)build/core/tasks/apicheck.mk || exit 1)
$(shell cp $(TOPDIR)device/gonk-build-hack/apicheck.mk-remove-warning.txt \
	$(TOPDIR)build/core/tasks/apicheck.mk.removed)

# Build system would build OTA-key for recovery image.  It requires a
# tool wrote in java.  This variable can stop it.
TARGET_NO_RECOVERY := true
