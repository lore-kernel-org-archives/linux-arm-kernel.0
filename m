From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 30 Dec 2009 02:26:26 -0500
Subject: [PATCH 0/2] fix enabling L2 on XSC3
Message-ID: <771cded00912292326n68adb3eck842148ac104f83a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling L2 should be very careful on XSC3. We could only enable L2
before or at the same time of enabling MMU. If L2 is enabled, we
shouldn't to disable it any more.

Now two patches are used to fix the behavior on enabling L2.
0001--ARM-pxa-unable-to-enable-L2-in-outer-cache.patch
0002--ARM-pxa-enable-L2-if-present-in-XSC3.patch

Thanks
Haojian
