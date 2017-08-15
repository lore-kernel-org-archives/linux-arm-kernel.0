From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Aug 2017 18:00:50 +0200
Subject: [PATCH 1/3] ARM: dts: r8a7745: add PFC support
In-Reply-To: <b3bcd091-4f96-c37a-54ec-c8ee5b0fd916@cogentembedded.com>
References: <20170415202036.987901107@cogentembedded.com>
 <CAMuHMdUPda7Mjo_P8p1V5a20XOAYM6GFf8Jqf0KLUuO7zAODeA@mail.gmail.com>
 <TY1PR06MB07025D9CE628A3D4CED37AA9B78D0@TY1PR06MB0702.apcprd06.prod.outlook.com>
 <b3bcd091-4f96-c37a-54ec-c8ee5b0fd916@cogentembedded.com>
Message-ID: <20170815160049.GC26748@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 01:39:56PM +0300, Sergei Shtylyov wrote:
> On 8/15/2017 11:47 AM, Chris Paterson wrote:
> 
> >>>Define the generic R8A7745 part of the PFC device node.
> >>>
> >>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >>Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> >It looks like the dependencies for this patch are met now [1].
> >
> >Are you happy to accept this patch? (and presumably the others in the series for the sk-rzg1e board).
> >
> >We plan to add GPIO support for r8a7745, but need this patch in place first.
> >
> >
> >[1] https://patchwork.kernel.org/patch/9705249/
> 
>    Actually, R8A774x PFC support has hit the Linus' tree in the meanwhile.
> Simon, please merge the .dts patches.
> 
> >Kind regards, Chris

Thanks, I have applied the series for v4.14.
