include $(THEOS)/makefiles/common.mk

# Find history version of precompiled WebKit
# https://github.com/Lessica/WebKitBuildArchives
WEBKIT_ROOT = ../WebKitArchive/274758/Release-iphonesimulator

TWEAK_NAME = SafariPlusWC

SafariPlusWC_FILES = HTMLMediaElement.xm libSubstitrate.mm
SafariPlusWC_CFLAGS = -fobjc-arc -I$(WEBKIT_ROOT)/usr/local/include -F$(WEBKIT_ROOT) -Wno-unused-variable -Wno-unused-function
SafariPlusWC_CCFLAGS += -std=c++17

ifeq ($(SIMJECT),1)
SafariPlusWC_EXTRA_FRAMEWORKS += CydiaSubstrate
SafariPlusWC_CFLAGS += -D SIMJECT=1
endif

SafariPlusWC_CFLAGS += -include WebContent.pch
SafariPlusWC_CCFLAGS += -include WebContent.pch
SafariPlusWC_PRIVATE_FRAMEWORKS = WebCore JavaScriptCore

include $(THEOS_MAKE_PATH)/tweak.mk
