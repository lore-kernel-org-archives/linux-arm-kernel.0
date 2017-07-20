From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 20 Jul 2017 12:18:10 +0200
Subject: [PATCH] MAINTAINERS: Add mediatek git repository
In-Reply-To: <20170609084354.26499-1-matthias.bgg@gmail.com>
References: <20170609084354.26499-1-matthias.bgg@gmail.com>
Message-ID: <a0602546-11b4-87be-c738-9539208ce8cb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2017 10:43 AM, Matthias Brugger wrote:
> Mediatek repository lives in github for quite a while.
> Add the repository to the file.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f7d568b8f133..41410639f650 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1554,6 +1554,7 @@ M:	Matthias Brugger <matthias.bgg@gmail.com>
>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>   L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> +T:	git https://github.com/mbgg/linux-mediatek.git for-next
>   F:	arch/arm/boot/dts/mt6*
>   F:	arch/arm/boot/dts/mt7*
>   F:	arch/arm/boot/dts/mt8*
> 


Looks like this got forgotten for v4.13-rc1.
Shall I take it through my tree for the next merge window?

Regards,
Matthias
