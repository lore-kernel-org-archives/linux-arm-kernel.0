From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 9 Jan 2013 06:02:40 +0000
Subject: [RFC v2 07/18] ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod
 with the right flags
In-Reply-To: <50EC35C3.4020701@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-8-git-send-email-vaibhav.bedia@ti.com>
 <50EC35C3.4020701@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD132@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 20:35:39, Shilimkar, Santosh wrote:
> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> > TPTC0 needs to be idled and put to standby under SW control.
> > Add the appropriate flags in the TPTC0 hwmod entry.
> >
> Can you please expand TPTC0 in chane log.

Third Party Transfer Controller. It's part of the DMA IP.
Will add it in the changelog.

> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> Patch is fine otherwise.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> 
