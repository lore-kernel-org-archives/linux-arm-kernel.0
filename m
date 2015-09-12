From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 12 Sep 2015 15:26:09 +0200
Subject: [PATCH 0/3] input / dt-bindings: Unify defining of evdev codes
Message-ID: <1442064372-3030-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is a patch-set to unify the defining of evdev codes between
uapi/linux/input.h and dt-bindings/input/input.h by using a single
shared file, rather then manually keeping things in sync.

The third patch is mainly included as an example using some new / extra
evcodes this makes available in dts files.

Assuming everyone involved likes this, I believe it is best for the
first 2 patches to be both merged to Dmitry's input tree, as the second
patch depends on the first one.

Regards,

Hans
