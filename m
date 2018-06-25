From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 25 Jun 2018 17:09:34 +0200
Subject: [PATCH v3 03/17] arm64: dts: marvell: fix CP110 ICU node size
In-Reply-To: <87a7ric3f1.fsf@bootlin.com>
References: <20180622151432.1566-1-miquel.raynal@bootlin.com>
 <20180622151432.1566-4-miquel.raynal@bootlin.com>
 <87a7ric3f1.fsf@bootlin.com>
Message-ID: <20180625170934.4cd4319a@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Mon, 25 Jun 2018 17:05:22 +0200, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> Hi Miquel,
>  
>  On ven., juin 22 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
> > specification).
> >
> > Fixes: 6ef84a827c37 ("arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K")
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>  
> 
> This patch was part of the last PR from arm-soc for Linus and should be
> part of 4.18-rc3, so if there is new version you can drop it.
> 

Sure, thanks for the reminder.

Miqu?l
