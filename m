From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Dec 2017 12:03:14 -0200
Subject: [PATCH 6/9] ARM: dts: imx7-colibri: specify usdhc1 supplies
In-Reply-To: <20171206153005.6144-6-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
 <20171206153005.6144-6-stefan@agner.ch>
Message-ID: <CAOMZO5AVK4mwUfKhTfrtAOr8ozEt+8+c+UqywwzGB0jaqtQCtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:30 PM, Stefan Agner <stefan@agner.ch> wrote:
> The usdhc1 controller instance is used to provide the default
> SD/MMC capabilities of the Colibri standard. The IO pins are
> supplied to the SoC on the module whereas the SD-card is powered
> by the Carrier Board supply.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
