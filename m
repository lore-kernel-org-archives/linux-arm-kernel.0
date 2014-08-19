From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Aug 2014 10:29:08 -0300
Subject: [PATCH v2] ARM: i.MX: dts: Add support for the Freescale i.MX1
 ADS board
In-Reply-To: <1408430027-4326-1-git-send-email-shc_work@mail.ru>
References: <1408430027-4326-1-git-send-email-shc_work@mail.ru>
Message-ID: <CAOMZO5B7oiy0Kuac2wMSMNBAVima+S0OR1rR-9p034S75rBzjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 3:33 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> This patch adds support for the Freescale (Motorola) i.MX1 ADS board.
> This change is intended to further remove non-DT support for this board.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Looks good, only one minor comment:

>
> +&iomuxc {
> +       imx1-motorola-ads {

Should be imx1-ads instead.
