From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 9 Jan 2013 05:38:26 +0000
Subject: [RFC v2 17/18] ARM: OMAP2+: AM33XX: Select Mailbox when PM is
 enabled
In-Reply-To: <50EC39BD.2020204@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-18-git-send-email-vaibhav.bedia@ti.com>
 <50EC39BD.2020204@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD08F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 20:52:37, Shilimkar, Santosh wrote:
> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> > PM services on AM33XX depend on mailbox for communication
> > with WKUP-M3 core so ensure that the right config options
> > are selected. Thanks to Kevin Hilman <khilman@deeprootsystems.com>
> > for the suggestion on updating the Kconfig and not just
> > the omap2plus_defconfig which was done in the previous version
> > of the AM33XX suspend-resume support.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Cc: Tony Lingren <tony@atomide.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> Unrelated to series. You can post this patch separately.
> 

Ok. I kept it in this series so that it does not look to be 
some random patch.

Regards,
Vaibhav
