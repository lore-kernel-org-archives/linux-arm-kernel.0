From: yao.yuan@nxp.com (Yao Yuan)
Date: Wed, 14 Dec 2016 07:52:07 +0000
Subject: [PATCH 5/5] Documentation: fsl-quadspi: Add fsl, ls1012a-qspi
 compatible string
In-Reply-To: <CAL_Jsq+jp_2m7D=Hv6TRa+1nQZhPis-0MPK5kOAWge_7RvN4Qg@mail.gmail.com>
References: <1481188984-43683-1-git-send-email-yao.yuan@freescale.com>
 <1481188984-43683-6-git-send-email-yao.yuan@freescale.com>
 <20161212170948.fq7v5lva4kgt6hly@rob-hp-laptop>
 <DB6PR0402MB2902DADEB4E6D06418AD311F899B0@DB6PR0402MB2902.eurprd04.prod.outlook.com>
 <CAL_Jsq+jp_2m7D=Hv6TRa+1nQZhPis-0MPK5kOAWge_7RvN4Qg@mail.gmail.com>
Message-ID: <AM5PR0402MB2900DCF4C944648A9E50535C899A0@AM5PR0402MB2900.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2016 at 05:23:02PM +0800, Rob Herring wrote:
> On Mon, Dec 12, 2016 at 8:47 PM, Yao Yuan <yao.yuan@nxp.com> wrote:
> > On Thu, Dec 13, 2016 at 05:23:02PM +0800, Rob Herring wrote:
> >> On Thu, Dec 08, 2016 at 05:23:04PM +0800, Yuan Yao wrote:
> >> > From: Yuan Yao <yao.yuan@nxp.com>
> >>
> >> Same problem in this subject too.
> >>
> >> >
> >> > new compatible string: "fsl,ls1012a-qspi".
> >> >
> >> > Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> >> > ---
> >> >  Documentation/devicetree/bindings/mtd/fsl-quadspi.txt | 1 +
> >> >  1 file changed, 1 insertion(+)
> >>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >
> > Thanks for your review.
> > And do you have any suggestion for this subject?
> 
> The problem is you have a space in the compatible string: "fsl, ls1012a-qspi"
> rather than "fsl,ls1012a-qspi"
> 
> Also, I prefer "dt/bindings: " as the beginning of binding patch subjects.
> 

Ok, Get it.

Thanks for your comments.
I will send v2 soon.
