From: andy@warmcat.com (Andy Green)
Date: Wed, 09 Mar 2011 14:04:05 +0000
Subject: [PATCH 2 15/18] I2C: OMAP2+: add correct functionality flags
	to all omap2plus i2c dev_attr
In-Reply-To: <4D778551.5010900@ti.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
	<20110308110912.23531.6379.stgit@otae.warmcat.com>
	<4D778551.5010900@ti.com>
Message-ID: <4D7788D5.8040603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2011 01:49 PM, Somebody in the thread at some point said:

Hi -

> I have one minor comment about the OMAP4 dev_attr position in the
> structure. The point here is just to be aligned with the template
> used by the generator.
>
> Acked-by: Benoit Cousson<b-cousson@ti.com>

> The generator is adding a (probably useless...) comment on top of the
> structure. For the comment I'd prefer to stick to the template. I'll
> do a massive cleanup when every OMAP4 drivers will be migrated to
> hwmod. And then OMAP2&  3 at some point will stick to that as well.

> The OMAP4 part should look like the patch below. I've just updated
> the scripts to add the new data you introduced.

I'm fine if you just want to replace that stanza with yours that matches 
the script's member ordering.  Thanks for a rapid review ^^

-Andy
