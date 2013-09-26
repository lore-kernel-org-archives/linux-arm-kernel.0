From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Sep 2013 08:27:15 -0300
Subject: [PATCH 2/3] ARM: mxs: crypto: Add Freescale MXS DCP driver
In-Reply-To: <1380194306-5243-2-git-send-email-marex@denx.de>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <1380194306-5243-2-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5AU_R5aeHKbkGRGuyXsVOVdUwdF5oZXdEZZYs442nFnEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Sep 26, 2013 at 8:18 AM, Marek Vasut <marex@denx.de> wrote:
> Add support for the MXS DCP block. The driver currently supports
> SHA-1/SHA-256 hashing and AES-128 CBC/ECB modes. The non-standard
> CRC32 is not yet supported.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> ---
>  drivers/crypto/Kconfig   |   17 +
>  drivers/crypto/Makefile  |    1 +
>  drivers/crypto/mxs-dcp.c | 1082 ++++++++++++++++++++++++++++++++++++++++++++++

What about the existing DCP driver at drivers/crypto/dcp.c ?

Why do we need to have two drivers for the same IP block? It looks
confusing to have both.

Regards,

Fabio Estevam
