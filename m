From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 11:20:36 -0700
Subject: [RESEND 3/4] clk: imx7d: Correct ahb clk parent select
In-Reply-To: <1522219599-10831-5-git-send-email-abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
 <1522219599-10831-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <152303883696.143116.13663538916966228102@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Abel Vesa (2018-03-27 23:46:38)
> From: Anson Huang <b20788@freescale.com>
> 
> Design team change the ahb's clk parent options but
> did NOT update the DOC accordingly in time, so the
> AHB/IPG's clk rate in clk tree is incorrect, AHB is
> 67.5MHz and IPG is 33.75MHz, but using scope to
> monitor them, they are actually 135MHz and 67.5MHz,
> update the clk parent option to make clk tree info
> correct.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next
