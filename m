From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Jan 2013 18:25:39 +0800
Subject: [PATCH v2] ARM: mxs: gpio-mxs: Add IRQ_TYPE_EDGE_BOTH support
In-Reply-To: <1359447393-2570-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1359447393-2570-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20130129102536.GF21504@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 09:16:33AM +0100, Gwenhael Goavec-Merou wrote:
> This patch adds support for IRQ_TYPE_EDGE_BOTH needed for some driver
> (gpio-keys).
> Inspired from gpio-mxc.c
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
