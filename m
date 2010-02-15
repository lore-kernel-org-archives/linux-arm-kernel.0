From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 15 Feb 2010 01:55:35 +0100
Subject: [PATCH 1/2] PXA3xx: Add support for preconfiguring SMEMC
Message-ID: <201002150155.35786.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SMEMC preconfiguration that was proposed in the "[PXA320] How to 
find  I/O registers, base address of ASIX ethernet chip?" thread.

Comments are welcome, as it is it's just a quick thing, but it works. This 
addition should be harmless.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-PXA3xx-Add-support-for-preconfiguring-SMEMC.patch
Type: text/x-patch
Size: 2394 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100215/d69cc135/attachment.bin>
