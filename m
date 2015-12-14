From: marex@denx.de (Marek Vasut)
Date: Mon, 14 Dec 2015 15:41:13 +0100
Subject: [PATCH V4 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <CAOMZO5DXnMfrdsUfptbErNdULAYCRg0KuPELYWYVxx5HtezHMw@mail.gmail.com>
References: <20151211110700.GD11252@tiger> <201512141512.24281.marex@denx.de>
 <CAOMZO5DXnMfrdsUfptbErNdULAYCRg0KuPELYWYVxx5HtezHMw@mail.gmail.com>
Message-ID: <201512141541.14107.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 14, 2015 at 03:17:04 PM, Fabio Estevam wrote:
> Hi Marek,

Hi!

> On Mon, Dec 14, 2015 at 12:12 PM, Marek Vasut <marex@denx.de> wrote:
> > So it was correct from the get-go ? Uh ...
> > 
> > Thanks for clarification, I will remember this :)
> 
> If you prefer, you can even remove this memory node entry from the dts
> and let the bootloader pass the correct amount of RAM to the kernel.
> 
> This is useful when a board has variants in RAM size.

Well that's a good idea, but some sort of sane default should be present
anyway, right ?

Best regards,
Marek Vasut
