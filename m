From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 07 Mar 2011 12:21:12 +0200
Subject: [PATCH V5 1/6] pxa3xx_nand: make scan procedure more clear
In-Reply-To: <AANLkTik2px-jmz0CSq03dYWjQWp2pMpdSmkKYwNWHjt=@mail.gmail.com>
References: <AANLkTinb7oZDzvD94RWLZqnLnaX5kY97CxJ+34eVJNmU@mail.gmail.com>
	<1299121710-6263-1-git-send-email-leiwen@marvell.com>
	<1299491371.2746.14.camel@localhost>
	<AANLkTik2px-jmz0CSq03dYWjQWp2pMpdSmkKYwNWHjt=@mail.gmail.com>
Message-ID: <1299493272.2746.26.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-03-07 at 18:00 +0800, Lei Wen wrote:
> Hi Artem,
> 
> On Mon, Mar 7, 2011 at 5:49 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > On Thu, 2011-03-03 at 11:08 +0800, Lei Wen wrote:
> >> The previous probe function is some kind of big part.
> >> This patch seperate the resource allocation to keep the probe process
> >> more clear than before.
> >>
> >> Signed-off-by: Lei Wen <leiwen@marvell.com>
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> >
> > It is a bit confusing that you sent 2 patches 1 and 6. What is in the
> > middle? Is it save to apply these 2 only?
> >
> 
> I just update the patch 1 and 6, since it add the comment as you mentioned.

Ah, I see, pushed the series to my l2-mtd-2.6.git, thanks.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
