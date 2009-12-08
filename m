From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 08 Dec 2009 12:45:22 -0800
Subject: HTC Dream: mmc compilation fixes
In-Reply-To: <20091206195953.GA26863@elf.ucw.cz>
References: <20091206195953.GA26863@elf.ucw.cz>
Message-ID: <1260305123.11826.25.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2009-12-06 at 20:59 +0100, Pavel Machek wrote:
> +
> +struct embedded_sdio_data {
> +        struct sdio_cis cis;
> +        struct sdio_cccr cccr;
> +        struct sdio_embedded_func *funcs;
> +        int num_funcs;
> +};


There's some indentation problems in this block, I'll fix it prior to
merging it..

Daniel
