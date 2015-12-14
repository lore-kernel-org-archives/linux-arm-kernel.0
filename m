From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 14 Dec 2015 12:45:16 -0200
Subject: [PATCH V4 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <201512141541.14107.marex@denx.de>
References: <20151211110700.GD11252@tiger> <201512141512.24281.marex@denx.de>
 <CAOMZO5DXnMfrdsUfptbErNdULAYCRg0KuPELYWYVxx5HtezHMw@mail.gmail.com>
 <201512141541.14107.marex@denx.de>
Message-ID: <CAOMZO5ATJEOcp8MqXxUaTYXw-cDHQiYPNJrJPy1XRjNoNsYTKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 12:41 PM, Marek Vasut <marex@denx.de> wrote:

> Well that's a good idea, but some sort of sane default should be present
> anyway, right ?

No, not needed. The bootloader should pass the correct RAM size.

See imx6qdl-hummingboard and imx6qdl-cubox-i.dtsi for a reference,
where 'memory' node is not passed.

Regards,

Fabio Estevam
