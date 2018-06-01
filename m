From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 12:10:44 -0700
Subject: [PATCH] clk: imx6sx: disable unnecessary clocks during clock
 initialization
In-Reply-To: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
References: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <152788024421.225090.2764368176678914931@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-05-16 22:00:47)
> Disable those unnecessary clocks during kernel boot up to save power,
> those modules clock should be managed by modules driver in runtime.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next
