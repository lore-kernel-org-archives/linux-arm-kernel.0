From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 10:49:52 -0700
Subject: [PATCH v2 06/22] clk: at91: allow clock registration from C code
In-Reply-To: <20181016142200.19741-7-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
 <20181016142200.19741-7-alexandre.belloni@bootlin.com>
Message-ID: <153979859211.5275.12311762962391053774@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alexandre Belloni (2018-10-16 07:21:44)
> Remove static keyword to allow functions to be used from other units. Also
> move some struct and function declarations to pmc.h
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
