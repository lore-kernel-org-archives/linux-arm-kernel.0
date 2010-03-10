From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 10 Mar 2010 02:47:26 +0100
Subject: [PATCH] Voipac PXA270
Message-ID: <201003100247.27059.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

This patch adds basic support for the Voipac PXA270 SBC.
The device consists of the following hardware:
- PXA270 @ 520 MHz
- 256MB RAM (sparsemem, 2*128MB regions)
- 64MB NOR flash
- 640x480 LCD
- Ports: 2xUHC, 1xUDC, 1xPCMCIA, VGA, FFUART, 2xPS2, Speaker, MIC

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Voipac-PXA270.patch
Type: text/x-patch
Size: 10549 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100310/42e9225d/attachment.bin>
