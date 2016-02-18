From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 18 Feb 2016 17:50:51 +0100
Subject: [PATCH v8 3/5] memory: mediatek: Add SMI driver
In-Reply-To: <20160216162641.GY18805@8bytes.org>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
 <56ADE959.2050309@gmail.com> <20160216141059.GT18805@8bytes.org>
 <56C340FB.1050607@arm.com> <20160216161009.GW18805@8bytes.org>
 <20160216162000.GI14509@arm.com> <20160216162641.GY18805@8bytes.org>
Message-ID: <1455814251.3937.27.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Am Dienstag, den 16.02.2016, 17:26 +0100 schrieb Joerg Roedel:
> On Tue, Feb 16, 2016 at 04:20:00PM +0000, Will Deacon wrote:
> > I'm more than happy to bake a branch containing all the page table stuff,
> > but Yong's stuff depends on it so I'll work with whatever is easiest for
> > you.
> 
> Okay, to the best is if you would collect all the page table patches and
> send me a pull-request. I pull that into my tree then and put Yong's
> stuff on-top.

could you provide a branch that I may then pull in, stack the
mediatek-drm driver patches (that depend on the SMI driver) on top and
have them merged via drm-next?

regards
Philipp
