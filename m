From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Feb 2011 11:21:41 -0800
Subject: [PATCH v6 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
In-Reply-To: <878vxvl9i6.fsf@ti.com>
References: <1296649335-31756-1-git-send-email-govindraj.raja@ti.com>
	<878vxvl9i6.fsf@ti.com>
Message-ID: <20110209192141.GB20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110204 14:27]:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > Changes invloves:
> > ----------------
> > 1) Addition of hwmod data for omap2/3/4.
> > 2) McSPI driver hwmod adaptation with cleanup of base address
> >    macros and using omap-device API's.
> > 3) Runtime Conversion of McSPI driver.
> >
> > Changes from v5:
> > ---------------
> > Rebased on top of 2.6.38-rc3 as per Kevin's comments.
> > http://www.spinics.net/lists/arm-kernel/msg112112.html
> 
> Thanks.
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks everybody, will queue.

Tony
