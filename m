From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 11 Mar 2011 21:44:05 +0100
Subject: [PATCH] ARM: mx51_efika: update platform data for new mfd changes
In-Reply-To: <20110307085358.GM29521@pengutronix.de>
References: <20110304080653.3f2c3f19@debxo>
	<20110307085358.GM29521@pengutronix.de>
Message-ID: <20110311204405.GE20247@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Mar 07, 2011 at 09:53:58AM +0100, Sascha Hauer wrote:
> On Fri, Mar 04, 2011 at 08:06:53AM -0800, Andres Salomon wrote:
> > Note that this relies on stuff currently in mfd's next tree, but this
> > is also a newer driver.  I'm not sure which tree it should go through,
> > as it's a problem that shows up in next.
> 
> Please ping me again when the mfd tree is in Linus master. I see no
> other chance fixing this on my side other than removing regulator
> support for efika completely for now. So I guess you have to live with
> the compile breakage for some time.
It would probably make sense for me to carry this driver then. Sascha, would
you be ok with it ? If that's so, could you please point me at a git commit
from your tree ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
