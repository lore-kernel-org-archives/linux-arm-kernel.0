From: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 11 Apr 2013 19:38:25 -0400
Subject: [PATCH 4/6] ata: i.MX PATA: add devicetree support
In-Reply-To: <1365067509-10186-5-git-send-email-s.hauer@pengutronix.de>
References: <1365067509-10186-1-git-send-email-s.hauer@pengutronix.de>
 <1365067509-10186-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <51674971.6010005@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 05:25 AM, Sascha Hauer wrote:
> Not much to do here, only the compatible entries have to be added.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   Documentation/devicetree/bindings/ata/imx-pata.txt | 17 +++++++++++++++++
>   drivers/ata/pata_imx.c                             |  9 +++++++++
>   2 files changed, 26 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt

applied 1-4
