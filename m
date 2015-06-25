From: davem@davemloft.net (David Miller)
Date: Thu, 25 Jun 2015 02:14:13 -0700 (PDT)
Subject: [PATCH] net/fsl: remove dependency FSL_SOC for Gianfar
In-Reply-To: <1435203278-40383-1-git-send-email-b18965@freescale.com>
References: <1435203278-40383-1-git-send-email-b18965@freescale.com>
Message-ID: <20150625.021413.321576291322782954.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Wang <b18965@freescale.com>
Date: Thu, 25 Jun 2015 11:34:38 +0800

> CONFIG_GIANFAR is not depended on FSL_SOC, it
> can be built on non-PPC platforms.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>

Applied.
