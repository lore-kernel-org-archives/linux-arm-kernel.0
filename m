From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Dec 2017 12:02:45 -0200
Subject: [PATCH 4/9] ARM: dts: imx7-colibri: use NAND_CE1 as GPIO
In-Reply-To: <20171206153005.6144-4-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
 <20171206153005.6144-4-stefan@agner.ch>
Message-ID: <CAOMZO5CMjteNszAzFwjiGMhxdMZJOTuvWWieBUU_XTOvD=6APg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:30 PM, Stefan Agner <stefan@agner.ch> wrote:
> All Colibri iMX7 SKUs use either single-die NAND or eMMC, hence
> NAND_CE1 is not used on the module and can be used as a GPIO by
> carrier boards.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
