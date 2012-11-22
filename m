From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Thu, 22 Nov 2012 05:46:14 +0000
Subject: [PATCH v3 2/5] mfd: tps65217: Set PMIC to shutdown on PWR_EN
 toggle
In-Reply-To: <20121121134758.GS18738@sortiz-mobl>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-3-git-send-email-anilkumar@ti.com>
 <20121121134758.GS18738@sortiz-mobl>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA78A8B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 19:17:58, Samuel Ortiz wrote:
> Hi Anilkumar,
> 
> On Tue, Nov 20, 2012 at 03:18:44PM +0530, AnilKumar Ch wrote:
> > From: Colin Foe-Parker <colin.foeparker@logicpd.com>
> > 
> > Set tps65217 PMIC status to OFF if power enable toggle is supported.
> > By setting this bit to 1 to enter PMIC to OFF state when PWR_EN pin
> > is pulled low. Also adds a DT flag to specify that device pmic
> > supports shutdown control or not.
> > 
> > Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
> > [anilkumar at ti.com: move the additions to tps65217 MFD driver]
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
> >  drivers/mfd/tps65217.c                             |   12 ++++++++++++
> >  2 files changed, 16 insertions(+)
> Applied, thanks.
> I suppose you're not expecting the whole patchset to go through one tree ?
> 

Hi Samuel,

Thanks much. Yes, I will request the corresponding owners to pick rest
of the patches.

Thanks
AnilKumar
