From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 15:34:48 -0700
Subject: [PATCH] clk: davinci: psc-da830: fix USB0 48MHz PHY clock
 registration
In-Reply-To: <20180507113457.4716-1-nsekhar@ti.com>
References: <20180507113457.4716-1-nsekhar@ti.com>
Message-ID: <152642368847.237094.1884631416189964435@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sekhar Nori (2018-05-07 04:34:57)
> USB0 48MHz PHY clock registration fails on DA830 because the
> da8xx-cfgchip clock driver cannot get a reference to USB0
> LPSC clock.
> 
> The USB0 LPSC needs to be enabled during PHY clock enable. Setup
> the clock lookup correctly to fix this.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---

Applied to clk-next

Did this need a fixes tag? And should it go into 4.17 final? Or it's not
causing problems right now?
