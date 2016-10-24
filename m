From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 24 Oct 2016 14:23:01 +0200
Subject: [PATCH] usb: gadget: udc: atmel: fix endpoint name
In-Reply-To: <935cce30-cf9d-4605-1f3e-ac8e934993e6@atmel.com>
References: <20160915150722.13103-1-alexandre.belloni@free-electrons.com>
 <c90099af-2537-cc41-2775-dd2ca41dc070@atmel.com>
 <331f5819-1f65-980d-486d-732342877f2c@atmel.com>
 <20160923150323.GB13744@kroah.com> <874m535dti.fsf@linux.intel.com>
 <935cce30-cf9d-4605-1f3e-ac8e934993e6@atmel.com>
Message-ID: <20161024122301.5432zefxbxiwv6uv@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/10/2016 at 13:59:47 +0200, Nicolas Ferre wrote :
> > Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> > 
> > If you prefer to pick it up as a pull request, I already have the patch
> > in my 'fixes' branch, just need to tag it and send it to you.
> 
> Felipe,
> 
> We agreed to delay this patch after the merge window is closed. But I
> feel that it's beginning to be urgent to make this patch go forward:
> actual users of our kernel are facing the issue:
> 
> https://lkml.org/lkml/2016/10/17/493
> 
> We're already at -rc2 and I don't see USB-fixes included...
> 

It is in Greg's branch:
http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/log/?h=usb-linus

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
