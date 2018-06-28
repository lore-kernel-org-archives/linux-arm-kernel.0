From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Jun 2018 13:30:40 -0300
Subject: [PATCH v2] dt-bindings: serial: imx: clarify rs485 support usage
In-Reply-To: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
References: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
Message-ID: <CAOMZO5DfJZUayL_JCH1UKSXYQTraoBTK7w3YHif6aLz0nFdh3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Thu, Jun 28, 2018 at 4:25 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> The i.MX UART peripheral uses the RST_B signal as input, and CTS_B as
> output. This is just like the DCE role in RS-232. This is true
> regardless of the "DTE mode" setting of this peripheral.
>
> As a result, rs485 support hardware must use the CTS_B signal to control
> the RS-485 transceiver. This is in contrast to generic rs485 kernel
> code, documentation, and DT property names that consistently refer to
> the RTS as transceiver control signal.
>
> Add a note in the DT binding document about that, to reduce the
> confusion somewhat.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Yes, this is helpful:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
