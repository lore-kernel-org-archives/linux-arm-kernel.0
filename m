From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 22:59:51 +0100
Subject: [PATCH 1/4] dma: mmp_pdma: Add the #requestors DT property
 documentation
In-Reply-To: <1455225798-9510-2-git-send-email-robert.jarzmik@free.fr>
References: <1455225798-9510-1-git-send-email-robert.jarzmik@free.fr>
 <1455225798-9510-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <2622040.i4begfCjyO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 February 2016 22:23:15 Robert Jarzmik wrote:
> @@ -12,6 +12,8 @@ Required properties:
>  Optional properties:
>  - #dma-channels: Number of DMA channels supported by the controller (defaults
>    to 32 when not specified)
> +- #requestors: Number of DMA requestor lines supported by the controller
> +  (defaults to 0 when not specified)
>  
> 

Most other ones use "#dma-requests" as the property name here, I think it makes
sense to stay with that convention.

	Arnd
