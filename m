From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 3 Sep 2009 04:43:29 +0200
Subject: [PATCH] Fix possibly uninitialized variable in PalmTC-pcmcia
Message-ID: <200909030443.29366.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This 'problem' actually cant cause a failure of the driver, but it's always
better to be correct.

Eric, please consider applying. Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Fix-possibly-uninitialized-variable-in-PalmTC-pcmcia.patch
Type: text/x-patch
Size: 916 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090903/af257d4c/attachment.bin>
