From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 4 Mar 2017 18:29:47 +0100 (CET)
Subject: [Outreachy kernel] [PATCH 0/3] staging: Clean up tests if NULL
 returned on failure
In-Reply-To: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
References: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
Message-ID: <alpine.DEB.2.20.1703041829220.2072@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sat, 4 Mar 2017, simran singhal wrote:

> This patch series tests if functions like kmalloc/kzalloc return NULL
> on failure. When NULL represents failure, !x is commonly used.
>
> simran singhal (3):
>   staging: rtl8192u: Clean up tests if NULL returned on failure
>   staging: speakup: Clean up tests if NULL returned on failure
>   staging: vc04_services: Clean up tests if NULL returned on failure

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

>
>  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c      | 2 +-
>  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c       | 2 +-
>  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c         | 2 +-
>  drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c              | 4 ++--
>  drivers/staging/speakup/main.c                                 | 2 +-
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe at googlegroups.com.
> To post to this group, send email to outreachy-kernel at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1488646015-7059-1-git-send-email-singhalsimran0%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
