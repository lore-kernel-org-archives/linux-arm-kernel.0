From: ylmao@marvell.com (Yilu Mao)
Date: Mon, 30 Apr 2012 21:22:49 +0800
Subject: [PATCH] ARM: cache-l2x0.c: save aux ctrl for resume in case that
 l2x0 is enabled before init
In-Reply-To: <20120430121125.GN10632@arm.com>
References: <4F99148B.4020900@marvell.com> <20120426094400.GD18136@arm.com>
 <4F991ED6.8060109@marvell.com> <20120426102815.GE18136@arm.com>
 <4F9924FB.7070308@marvell.com> <20120426103840.GA6294@arm.com>
 <4F9927F2.5060408@marvell.com> <20120426105651.GB6294@arm.com>
 <4F992B80.6040207@marvell.com> <4F9B8D1C.6090400@marvell.com>
 <20120430121125.GN10632@arm.com>
Message-ID: <4F9E9229.4020904@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2012 08:11 PM, Catalin Marinas wrote:
> On Sat, Apr 28, 2012 at 07:24:28AM +0100, Yilu Mao wrote:
>> Do you agree with this patch to be merged?
>
> I would rather re-read the aux_ctrl register again after it was set (if
> L2 is disabled) and store this value. It makes sense if some of the bits
> are reserved, at least we have the real value.
>
Ok, I have provided a V4 patch including this.
Please help to review.

-- 
Thanks.

Best Wishes,
Yilu Mao
