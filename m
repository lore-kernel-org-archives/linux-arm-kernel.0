From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 05 Aug 2016 10:55:44 +0200
Subject: [PATCH v4 1/7] clk: rockchip: add clock flag parameter when
 register pll
In-Reply-To: <57A45369.7020804@gmail.com>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
 <4870605.nd4Eof6Gm1@phil> <57A45369.7020804@gmail.com>
Message-ID: <1618511.YfjKKMY3nc@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

Am Freitag, 5. August 2016, 16:50:49 schrieb hl:
> On 2016?08?05? 06:37, Heiko Stuebner wrote:
> > Am Freitag, 29. Juli 2016, 15:56:55 schrieb Lin Huang:
> >> From: Heiko St?bner <heiko@sntech.de>
> >> 
> >> add clock flag parameter so we can pass specific clock flag
> >> (like CLK_GET_RATE_NOCACHE etc..)to pll driver.
> >> 
> >> Signed-off-by: Heiko St?bner <heiko@sntech.de>
> >> Signed-off-by: Lin Huang <hl@rock-chips.com>
> > 
> > applied to my clock branch for 4.9 after some minor edits on the commit
> > message.
> 
>   I can not found your clock branch for 4.9, can you share me the patch
> ID, i want
> cherry-pick it to my downstream branch.

sorry forgot to push yesterday evening. The patch is at [0].

Please keep in mind, that I'll rebase that branch onto 4.8-rc1 once it 
gets released on sunday. So the commit id is volatile till then.
[Same is true for all my 4.9 branch of course, I just pick patches already
to reduce the number of patches in my inbox :-) ]


Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.9-clk/next&id=24bdd1a5a2cc706b8c4820a1976dd4eed56716e4
