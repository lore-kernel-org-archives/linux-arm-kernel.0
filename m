From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Jan 2014 20:32:53 +0100
Subject: [PATCH v8 0/4] ohci and ehci-platform clks, phy, be and dt support
Message-ID: <1390419177-6481-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Although v7 was intended as the final version here is a v8, compared to v7
this contains 2 small fixes to the dt-bindings documentation so that the
examples there match the dt-node naming rules.

Besides that I've also rolled v2 of my patches to also add support for
specifying controller endianness through dt into this set.

Regards,

Hans
