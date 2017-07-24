From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Jul 2017 10:04:08 -0300
Subject: [PATCH v2 2/2] ARM: dts: imx6qdl-nitrogen6x: fix USB PHY reset
In-Reply-To: <20170724125958.11939-3-gary.bisson@boundarydevices.com>
References: <20170724085005.22101-1-gary.bisson@boundarydevices.com>
 <20170724125958.11939-1-gary.bisson@boundarydevices.com>
 <20170724125958.11939-3-gary.bisson@boundarydevices.com>
Message-ID: <CAOMZO5A-8WDQJtoCmRxMFXF1OALpDSCCxNmVmZXoNBgWdyCWvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 9:59 AM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> Declared as a regulator since the driver doesn't have a reset-gpios
> property for this.
>
> This ensures that the PHY is woken up, not depending on the state the
> second stage bootloader leaves the pin.
>
> This is a workaround until a proper mechanism is provided to reset such
> devices like the pwrseq library [1] for instance.
>
> [1] https://lkml.org/lkml/2017/2/10/779
>
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
