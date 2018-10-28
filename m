From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 28 Oct 2018 22:11:43 +0100 (CET)
Subject: [PATCH RFC 18/18] staging: vchiq: add more tasks to the TODO list
In-Reply-To: <20181026134813.7775-19-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-19-nsaenzjulienne@suse.de>
Message-ID: <847891613.4295.1540761103425@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> The more the better.

Please try to find a better commit log ;-)

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../staging/vc04_services/interface/vchi/TODO | 46 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchi/TODO b/drivers/staging/vc04_services/interface/vchi/TODO
> index 0b3ec75ff627..bf2135826431 100644
> --- a/drivers/staging/vc04_services/interface/vchi/TODO
> +++ b/drivers/staging/vc04_services/interface/vchi/TODO
> @@ -27,8 +27,8 @@ unused.
>  3) Make driver more portable
>  
>  Building this driver with arm/multi_v7_defconfig or arm64/defconfig
> -leads to data corruption during the following command: 
> -  
> +leads to data corruption during the following command:
> +

I assume this wasn't intended.

Btw after applying Phil's patch series. This point can be dropped.

Beside that i'm fine with the additions.
