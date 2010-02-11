From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 11 Feb 2010 13:42:43 +0100
Subject: [PATCH 5/5] input: support onkey in 88pm860x
In-Reply-To: <20100205171108.GA28694@core.coreip.homeip.net>
References: <771cded01002030504ye3416c8nafe21be405237ace@mail.gmail.com>
	<20100203173628.GB30600@core.coreip.homeip.net>
	<771cded01002040308t3fe112e5leb60bc969fbfcfb@mail.gmail.com>
	<20100205154211.GE3448@sortiz.org>
	<20100205171108.GA28694@core.coreip.homeip.net>
Message-ID: <20100211124242.GE3136@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmittry,

On Fri, Feb 05, 2010 at 09:11:09AM -0800, Dmitry Torokhov wrote:
> Hi Samuel,
> 
> On Fri, Feb 05, 2010 at 04:42:12PM +0100, Samuel Ortiz wrote:
> > On Thu, Feb 04, 2010 at 06:08:42AM -0500, Haojian Zhuang wrote:
> > > Fix and format the new patch.
> > Dmitry, are you ok with this new version ?
> > 
> 
> Looks OK. It could be made a bit simpler in error path by requesting IRQ
> after allocating input device but before registering it (input devices
> can take events s soon as they ghave been allocated with
> input_allocate_device) but it is not that important.
Thanks, I'm taking this patch then.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
