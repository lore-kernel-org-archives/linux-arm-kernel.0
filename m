From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 20:38:58 +0000
Subject: [PATCH 1/3] arm: ignore devicetree blobs.
In-Reply-To: <3629df9b5b96d3a3a63a34ebf6ddfca2fd72ccfc.1329936660.git.jason@lakedaemon.net>
References: <cover.1329936660.git.jason@lakedaemon.net>
 <3629df9b5b96d3a3a63a34ebf6ddfca2fd72ccfc.1329936660.git.jason@lakedaemon.net>
Message-ID: <201202222038.59477.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012, Jason Cooper wrote:
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
> index ce1c5ff..3c79f85 100644
> --- a/arch/arm/boot/.gitignore
> +++ b/arch/arm/boot/.gitignore
> @@ -3,3 +3,4 @@ zImage
>  xipImage
>  bootpImage
>  uImage
> +*.dtb

This patch should probably go through Russell's tree. It looks obviously
correct so unless someone complains in the next few days, just put it into
the patch tracker system.

	Arnd
