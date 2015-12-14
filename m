From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 14 Dec 2015 12:17:04 -0200
Subject: [PATCH V4 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <201512141512.24281.marex@denx.de>
References: <20151211110700.GD11252@tiger> <201512140456.08114.marex@denx.de>
 <566EC9E6.6060402@cogentembedded.com>
 <201512141512.24281.marex@denx.de>
Message-ID: <CAOMZO5DXnMfrdsUfptbErNdULAYCRg0KuPELYWYVxx5HtezHMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Dec 14, 2015 at 12:12 PM, Marek Vasut <marex@denx.de> wrote:

> So it was correct from the get-go ? Uh ...
>
> Thanks for clarification, I will remember this :)

If you prefer, you can even remove this memory node entry from the dts
and let the bootloader pass the correct amount of RAM to the kernel.

This is useful when a board has variants in RAM size.

Regards,

Fabio Estevam
