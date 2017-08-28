From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 28 Aug 2017 12:16:51 +0900
Subject: [PATCH] pinctrl: uniphier: fix members of rmii group for Pro4
In-Reply-To: <CAK7LNASqOQsTDjCNkWjtxp__gns_0kM6BVgsGuNQFpUc3MVM7g@mail.gmail.com>
References: <1503886886-30065-1-git-send-email-hayashi.kunihiko@socionext.com>
 <CAK7LNASqOQsTDjCNkWjtxp__gns_0kM6BVgsGuNQFpUc3MVM7g@mail.gmail.com>
Message-ID: <CAK7LNARqNZe0qgWG_rKAmsnutYVF_=EiHSfvN3GsV=1G_nTfeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-08-28 11:28 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2017-08-28 11:21 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
>> The ether_rmii_groups should have "ether_rmii" and "ether_rmiib" as
>> members. This patch replaces to them.
>
>
> Linus,
> When you pick up this, please add
>
> Fixes: 1e359ab1285e ("1e359ab1285eaa7")

My mistake.  I mean,

Fixes: 1e359ab1285e ("pinctrl: uniphier: add Ethernet pin-mux settings")



>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>
>
> Otherwise, looks good to me.
>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
