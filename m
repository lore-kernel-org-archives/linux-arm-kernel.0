From: horms@verge.net.au (Simon Horman)
Date: Wed, 30 Aug 2017 09:32:14 +0200
Subject: [PATCH v2] ARM: dts: r8a7743: add IIC cores to dtsi
In-Reply-To: <b7434757-b151-5971-2b5f-525eeaf11467@cogentembedded.com>
References: <12d923ba-184c-ef59-f27b-41a7592a5f93@cogentembedded.com>
 <1502704398-28378-1-git-send-email-biju.das@bp.renesas.com>
 <TY1PR06MB07027D9A55FBFE2D591CEDCFB7840@TY1PR06MB0702.apcprd06.prod.outlook.com>
 <b7434757-b151-5971-2b5f-525eeaf11467@cogentembedded.com>
Message-ID: <20170830073214.GL10398@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 03:23:39PM +0300, Sergei Shtylyov wrote:
> On 08/22/2017 12:10 PM, Chris Paterson wrote:
> 
> >>From: Biju Das [mailto:biju.das at bp.renesas.com]
> >>Sent: 14 August 2017 10:53
> >>
> >>Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> >>---
> >>v1-->v2
> >>    Corrected the resets property for i2c6 device node.
> >
> >Are you happy with this version of the patch?
> >
> >Or is the discussion for moving to 'iic' still alive?
> 
>    Yes, appears so. I'd like the labels to be named iic<n>.

Chirs, I'm marking this as "Changes Requested" and expecting to see iic
in v3 when you are ready.
