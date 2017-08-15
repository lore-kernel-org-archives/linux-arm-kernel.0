From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 15 Aug 2017 08:47:40 +0000
Subject: [PATCH 1/3] ARM: dts: r8a7745: add PFC support
In-Reply-To: <CAMuHMdUPda7Mjo_P8p1V5a20XOAYM6GFf8Jqf0KLUuO7zAODeA@mail.gmail.com>
References: <20170415202036.987901107@cogentembedded.com>
 <CAMuHMdUPda7Mjo_P8p1V5a20XOAYM6GFf8Jqf0KLUuO7zAODeA@mail.gmail.com>
Message-ID: <TY1PR06MB07025D9CE628A3D4CED37AA9B78D0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

> From: linux-renesas-soc-owner at vger.kernel.org [mailto:linux-renesas-soc-
> owner at vger.kernel.org] On Behalf Of Geert Uytterhoeven
> Sent: 20 April 2017 15:09
> To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Simon Horman <horms@verge.net.au>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Linux-
> Renesas <linux-renesas-soc@vger.kernel.org>; devicetree at vger.kernel.org;
> Magnus Damm <magnus.damm@gmail.com>; Russell King
> <linux@armlinux.org.uk>; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/3] ARM: dts: r8a7745: add PFC support
> 
> On Sat, Apr 15, 2017 at 10:18 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Define the generic R8A7745 part of the PFC device node.
> >
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

It looks like the dependencies for this patch are met now [1].

Are you happy to accept this patch? (and presumably the others in the series for the sk-rzg1e board).

We plan to add GPIO support for r8a7745, but need this patch in place first.


[1] https://patchwork.kernel.org/patch/9705249/

Kind regards, Chris
