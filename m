From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 17 Dec 2017 19:52:50 -0200
Subject: [PATCH v2 8/9] ARM: dts: imx7-colibri: add MCP2515 CAN controller
In-Reply-To: <20171217203723.15896-8-stefan@agner.ch>
References: <20171217203723.15896-1-stefan@agner.ch>
 <20171217203723.15896-8-stefan@agner.ch>
Message-ID: <CAOMZO5CPeY3dwRsTaw9Z-sfgvsYKceU1SaaY_pw=nis=Q8OFrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 17, 2017 at 6:37 PM, Stefan Agner <stefan@agner.ch> wrote:
> The Colibri Evaluation Carrier Board provides a MCP2515 CAN
> controller connected via SPI. Note that the i.MX 7 provides
> an internal CAN controller which is much better suited for CAN
> operations. Using the MCP2515 with a Colibri iMX7 module is
> mainly useful to test the SPI interface.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
