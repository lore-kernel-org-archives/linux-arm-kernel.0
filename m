From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Tue, 15 May 2018 10:22:03 +0300
Subject: [PATCH] usb: gadget: composite: fill bcdUSB as 0x0320 for
 SuperSpeed or higher speeds
In-Reply-To: <1525913200.32173.3.camel@mhfsdcap03>
References: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com>
 <8736z1kqrq.fsf@linux.intel.com> <1525913200.32173.3.camel@mhfsdcap03>
Message-ID: <87efid9yec.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> On Wed, 2018-05-09 at 14:33 +0300, Felipe Balbi wrote:
>> Hi,
>> 
>> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
>> > The USB3CV version 2.1.80 (March 26, 2018) requires all devices
>> > ( gen1, gen2, single lane, dual lane) to return the value of 0x0320
>> > in the bcdUSB field
>> 
>> this sounds really odd. What happens when I get a USB 3.1 compliant
>> device off-the-shelf and run it through USB3CV? will it fail now?
> Yes, it will fail, the last version requires it 0x0310
>> 
>> Care to share a screenshot or the raw html of the test result?
> A screenshot is attached

really odd. But I'll apply the patch.

thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180515/20749c58/attachment.sig>
