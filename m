From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Oct 2017 12:56:49 -0300
Subject: [PATCH v3 2/2] ARM: dts: imx51: Fix inconsistent display port
 names
In-Reply-To: <1507213901-1349-2-git-send-email-marco.franchi@nxp.com>
References: <1507213901-1349-1-git-send-email-marco.franchi@nxp.com>
 <1507213901-1349-2-git-send-email-marco.franchi@nxp.com>
Message-ID: <CAOMZO5A8LmN9BW2PrgktJ6A5M_==f=o8NfiVoOguZdtmZdjNog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 11:31 AM, Marco Franchi <marco.franchi@nxp.com> wrote:
> Contrary to later i.MX SoCs, the parallel display interface pad groups on
> i.MX51 are called DISP1 and DISP2 in the Reference Manual, not DISP0 and
> DISP1.
>
> Fix this inconsistence by changing the DISP names in the i.mx51 dts.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
