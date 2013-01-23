From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 22 Jan 2013 20:08:47 -0500
Subject: [PATCH v3] clk: mvebu/clk-cpu.c: fix memory leakage
In-Reply-To: <20130115184423.GC7211@gmail.com>
References: <1358183892-28928-1-git-send-email-dinggnu@gmail.com>
 <50F563EC.3030804@free-electrons.com>
 <20130115152307.GA25615@gmail.com>
 <20130115153716.GF13433@titan.lakedaemon.net>
 <50F584F5.6030007@free-electrons.com>
 <20130115182629.GB7211@gmail.com>
 <50F5A1A9.2030803@free-electrons.com>
 <20130115184423.GC7211@gmail.com>
Message-ID: <20130123010847.GA1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 07:44:26PM +0100, Cong Ding wrote:
> the variable cpuclk and clk_name should be properly freed when error happens.
> 
> Signed-off-by: Cong Ding <dinggnu@gmail.com>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  drivers/clk/mvebu/clk-cpu.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to mvebu/fixes with MikeT's Ack.

thx,

Jason.
