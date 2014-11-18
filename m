From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 18 Nov 2014 12:10:49 +0100
Subject: [PATCH v3 0/2] dt-bindings: simplefb: Drop the advice about using a
 specific path for nodes
Message-ID: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

So it turns out we needed a v3, as I mistakenly went with "sunxi," as vendor
prefix for the allwinner specific properties, but the registered vendor prefix
for allwinner is "allwinnner,", this version fixes this.

Changes in v3: Use proper "allwinnner," for the compatible string and vendor
specific properties.

Changes in v2: Changed the simplefb-sunxi bindings to use a single
sunxi,pipeline string property instead of a sunxi,pipeline int and a
sunxi,output string property.

This patch set is all acked up, and a fix to the binding changes you've
already queued for 3.19, so please queue these 2 patches for 3.19.

Thanks & Regards,

Hans
