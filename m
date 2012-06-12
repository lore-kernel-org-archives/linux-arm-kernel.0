From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 10:10:41 -0700
Subject: [PATCH] clk: Constify struct clk_init_data
In-Reply-To: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120612171041.GF19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120514-15:12, Mark Brown wrote:
> Allow drivers to declare their clk_init_data const, the framework really
> shouldn't be modifying the data.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks for the patch Mark.  I've pulled into clk-next for testing.

Regards,
Mike
