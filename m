From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Dec 2012 13:21:08 -0500
Subject: [PATCH 1/2] ARM: Dove: Add pinctrl clock to DT
In-Reply-To: <50BA495B.3010008@gmail.com>
References: <20121125152845.GV15800@titan.lakedaemon.net>
 <1353921525-25163-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdZcHsvSG-vfynd0jYrs0kVYqPsgtroSrQdz4yDZexQZjA@mail.gmail.com>
 <20121201181313.GF12509@titan.lakedaemon.net>
 <50BA495B.3010008@gmail.com>
Message-ID: <20121201182108.GH12509@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 01, 2012 at 07:15:55PM +0100, Sebastian Hesselbarth wrote:
> On 12/01/2012 07:13 PM, Jason Cooper wrote:
> >On Sat, Dec 01, 2012 at 06:07:06PM +0100, Linus Walleij wrote:
> >>On Mon, Nov 26, 2012 at 10:18 AM, Sebastian Hesselbarth
> >><sebastian.hesselbarth@gmail.com>  wrote:
> >>
> >>>During merge of the mvebu patches a clock gate for pinctrl was
> >>>lost. This patch just readds the clock gate.
> >>>
> >>>Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
> >>
> >>Acked-by: Linus Walleij<linus.walleij@linaro.org>
> >>
> >>So who's supposed to merge this patch? Me? The MVEBU-maintainer?
> >
> >I'll take it and merge it in once v3.8-rc1 drops.
> 
> Linus, Jason,
> 
> I agree to take it through Jason's tree but please take v2 of
> the patch as there has been a small change in one of the patches.

Yes, I have it flagged.

thx,

Jason.
