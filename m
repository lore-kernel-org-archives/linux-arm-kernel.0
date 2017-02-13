From: alison.wang@nxp.com (Alison Wang)
Date: Mon, 13 Feb 2017 06:59:49 +0000
Subject: [PATCH v2 2/2] mtd: nand: Update dependency of IFC for LS1021A
In-Reply-To: <20170206100542.65f19dc5@bbrezillon>
References: <1483411266-45875-1-git-send-email-b18965@freescale.com>
 <1483411266-45875-2-git-send-email-b18965@freescale.com>
 <4e04eb5e-fb53-f71e-ee49-0872a6c11e97@gmail.com>
 <DB6PR0401MB2584606EC932BF1FAED788E1F4610@DB6PR0401MB2584.eurprd04.prod.outlook.com>
 <ffb2c20d-3aeb-6f5a-1880-3bed0c964821@gmail.com>
 <DB6PR0401MB2584DBE5D6496F44B7169B49F4600@DB6PR0401MB2584.eurprd04.prod.outlook.com>
 <20170206100542.65f19dc5@bbrezillon>
Message-ID: <DB6PR0401MB25847A37C6EED9A531A51F36F4590@DB6PR0401MB2584.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Boris,

> On Thu, 5 Jan 2017 02:02:30 +0000
> Alison Wang <alison.wang@nxp.com> wrote:
> 
> > > On 01/04/2017 02:46 AM, Alison Wang wrote:
> > > >> On 01/03/2017 03:41 AM, Alison Wang wrote:
> > > >>> As NAND support for Freescale/NXP IFC controller is available
> on
> > > >>> LS1021A, the dependency for LS1021A is added.
> > > >>
> > > >> Does LS stand for LayerScape ? Yes it does. So why does
> > > >> ARCH_LAYERSCAPE not cover LS1021 ?
> > > > [Alison Wang] LS1021A is an earlier product and is not compatible
> > > with later Layerscape architecture. So ARCH_LAYERSCAPE can't cover
> > > LS1021A.
> > >
> > > Ah ok, I see. That information would be useful in the commit
> message
> > > ;-)
> > >
> > [Alison Wang] Ok. :)
> 
> Would you mind sending a v3 with the updated commit message?
> 
[Alison Wang] I will send the v3 patches at once. :)


Best Regards,
Alison Wang
