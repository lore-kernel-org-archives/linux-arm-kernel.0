From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 09 May 2018 14:33:13 +0300
Subject: [PATCH] usb: gadget: composite: fill bcdUSB as 0x0320 for
 SuperSpeed or higher speeds
In-Reply-To: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com>
References: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com>
Message-ID: <8736z1kqrq.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> The USB3CV version 2.1.80 (March 26, 2018) requires all devices
> ( gen1, gen2, single lane, dual lane) to return the value of 0x0320
> in the bcdUSB field

this sounds really odd. What happens when I get a USB 3.1 compliant
device off-the-shelf and run it through USB3CV? will it fail now?

Care to share a screenshot or the raw html of the test result?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/6bab0fb4/attachment.sig>
