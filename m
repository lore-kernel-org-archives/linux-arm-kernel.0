From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 19 Nov 2012 16:49:24 +0400
Subject: [PATCH 3/3] net: mvneta: adjust multiline comments to net/ style
In-Reply-To: <1353322834-16952-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353322834-16952-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353322834-16952-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <50AA2AD4.6030007@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-11-2012 15:00, Thomas Petazzoni wrote:

> As reported by checkpatch, the multiline comments for net/ and
> drivers/net/ have a slightly different format than the one used in the
> rest of the kernel, so we adjust our multiline comments accordingly.

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>   drivers/net/ethernet/marvell/mvneta.c |   84 ++++++++++++++++-----------------
>   1 file changed, 42 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index a7826f0..d9dadee 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -178,8 +178,7 @@
>   /* Napi polling weight */
>   #define MVNETA_RX_POLL_WEIGHT		64
>
> -/*
> - * The two bytes Marvell header. Either contains a special value used
> +/* The two bytes Marvell header. Either contains a special value used

    Why the heck you're doing this? It's the preferred style, see 
Documentation/CodingStyle, chapter 8.

WBR, Sergei
