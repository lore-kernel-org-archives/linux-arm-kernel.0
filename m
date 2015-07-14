From: claudiu.manoil@freescale.com (Manoil Claudiu)
Date: Tue, 14 Jul 2015 16:13:12 +0000
Subject: [PATCH v2] dts: ls1021a: Add dts nodes for eTSEC0, eTSEC1 and
 eTSEC2
In-Reply-To: <CAOMZO5A2ftfUhioXpSnbGMxiV-fTePgHqk6zj2ysHe2wUY7JFg@mail.gmail.com>
References: <20150713133138.GO23464@tiger>
 <1436888777-29742-1-git-send-email-claudiu.manoil@freescale.com>
 <CAOMZO5A2ftfUhioXpSnbGMxiV-fTePgHqk6zj2ysHe2wUY7JFg@mail.gmail.com>
Message-ID: <BY2PR03MB409415EF1E3F398DBF096E49C9B0@BY2PR03MB409.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Tuesday, July 14, 2015 6:57 PM
> To: Manoil Claudiu-B08782
> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel; Shawn Guo; Wang Huan-B18965
> Subject: Re: [PATCH v2] dts: ls1021a: Add dts nodes for eTSEC0, eTSEC1 and
> eTSEC2
> 
> On Tue, Jul 14, 2015 at 12:46 PM, Claudiu Manoil
> <claudiu.manoil@freescale.com> wrote:
> > This patch adds generic dts nodes for eTSEC0, eTSEC1 and eTSEC2.
> >
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> >
> > Enable support for the second interrupt group register block
> > and the corresponding Rx/Tx/Err interrupt sources, for each
> > eTSEC node.  DT binding documentation updates.
> >
> > Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> 
> It seems you missed to put Alison in the From field.
> 
> You should also put his Signed-off-by tag just before yours.

Is this a rule invented by you?  Last time I checked this was a
valid patch format.  Also, this time I sent the (updated) patch,
not Alison, which should explain the "From" part. Thanks.
