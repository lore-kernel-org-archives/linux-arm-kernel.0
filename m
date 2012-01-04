From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Jan 2012 11:08:02 -0700
Subject: [PATCH v2 02/10] i2c: OMAP: Add DT support for i2c controller
In-Reply-To: <4F0455D8.7060904@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-3-git-send-email-b-cousson@ti.com>
 <87hb14q7vj.fsf@ti.com> <4F0455D8.7060904@ti.com>
Message-ID: <20120104180802.GI15503@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 02:36:24PM +0100, Cousson, Benoit wrote:
> Hi Kevin,
> 
> On 12/14/2011 2:06 AM, Kevin Hilman wrote:
> >Benoit Cousson<b-cousson@ti.com>  writes:
> >
> >>Add initial DT support to retrieve the frequency using a
> >>DT attribute instead of the pdata pointer if of_node exist.
> >>
> >>Add documentation for omap i2c controller binding.
> >>
> >>Based on original patches from Manju and Grant.
> >>
> >>Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> >>Cc: Ben Dooks<ben-linux@fluff.org>
> >
> >This seems indepenent from the rest of the series, and I can queue up
> >for merge via the I2C tree.
> >
> >Benoit, please confirm that we shouldn't have any problems if this patch
> >goes independently.
> >
> >Grant/Rob, with your ack on the bindings, I can queue this up for the
> >I2C maintainers along with some other OMAP I2C changes for v3.3.
> 
> I removed the nasty bindings and got the Reviewed-by: from Rob for
> the v4 [1].
> 
> Could you take it in your branch? I've just tried merging your
> for_3.3/i2c/misc on top of my for_3.3/3_omap_dt_i2c_twl branch and
> tested it successfully on OMAP4 DT boot.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> 
> Thanks,
> Benoit
> 
> 
> [1] http://lkml.org/lkml/2011/12/22/176
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
