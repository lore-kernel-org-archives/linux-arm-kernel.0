From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 10 May 2018 08:03:06 +0800
Subject: [PATCH] usb: gadget: composite: fill bcdUSB as 0x0320 for
 SuperSpeed or higher speeds
In-Reply-To: <8736z1kqrq.fsf@linux.intel.com>
References: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com>
 <8736z1kqrq.fsf@linux.intel.com>
Message-ID: <1525910586.25162.40.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-05-09 at 14:33 +0300, Felipe Balbi wrote:
> Hi,
> 
> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> > The USB3CV version 2.1.80 (March 26, 2018) requires all devices
> > ( gen1, gen2, single lane, dual lane) to return the value of 0x0320
> > in the bcdUSB field
> 
> this sounds really odd. What happens when I get a USB 3.1 compliant
> device off-the-shelf and run it through USB3CV? will it fail now?
It will fail, the last version require it 0x0310
> 
> Care to share a screenshot or the raw html of the test result?
A screenshot is attached
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: dev_desc_test_fail.png
Type: image/png
Size: 16866 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180510/64cc8879/attachment-0001.png>
