From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 27 Sep 2010 16:46:11 +0200
Subject: [PATCH v2 08/10] TWL IRQ: Fix fucntion declaration warnings
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8D1A@dbde02.ent.ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	<1285063280-4057-9-git-send-email-manjugk@ti.com>
	<20100927111609.GF2560@sortiz-mobl>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8CCE@dbde02.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8D1A@dbde02.ent.ti.com>
Message-ID: <20100927144610.GH2560@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath,

On Mon, Sep 27, 2010 at 07:19:33PM +0530, G, Manjunath Kondaiah wrote:
> > > No, we don't want to export those. Try defining them as extern from 
> > > twl*-irq.c.
> > 
> > Having extern in .c file will generate checkpatch warning as:
> > WARNING: externs should be avoided in .c files
> 
> As an alternate, how about having twl-core.h in drivers/mfd and defining them
> as extern so that these API's will be available only to files under drivers/mfd?
>
That would be better, yes. Even though exporting those definititions through
linux/i2c/twl.h is harmless.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
