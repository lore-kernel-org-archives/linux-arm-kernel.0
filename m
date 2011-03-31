From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 31 Mar 2011 11:06:24 +0900
Subject: [PATCH] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
In-Reply-To: <1301453955-15759-2-git-send-email-horms@verge.net.au>
References: <1301453955-15759-1-git-send-email-horms@verge.net.au>
	<1301453955-15759-2-git-send-email-horms@verge.net.au>
Message-ID: <AANLkTin6TdEWjQoNCGw1gV1BnzHjOQss9DA_0BRMdvNE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 11:59 AM, Simon Horman <horms@verge.net.au> wrote:
> This allows a ROM-able zImage to be written to eSD and for SuperH Mobile
> ARM to boot directly from the SDHI hardware block.
>
> This is achieved by the MaskROM loading the first portion of the image into
> MERAM and then jumping to it. ?This portion contains loader code which
> copies the entire image to SDRAM and jumps to it. From there the zImage
> boot code proceeds as normal, uncompressing the image into its final
> location and then jumping to it.
>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Hi Simon,

Thanks for your work on this. v6 of this patch looks good to me!

Acked-by: Magnus Damm <damm@opensource.se>
