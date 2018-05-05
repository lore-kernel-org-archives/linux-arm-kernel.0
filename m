From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 04 May 2018 19:55:26 -0700
Subject: [PATCH] clk: imx6ul: fix periph clk2 clock mux selection
In-Reply-To: <20180418125254.4397-1-stefan@agner.ch>
References: <20180418125254.4397-1-stefan@agner.ch>
Message-ID: <152548892600.138124.3143140012763491118@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stefan Agner (2018-04-18 05:52:54)
> According to the data sheet the 3rd choice is the bypass clock
> of pll2. This should not have any effect in practice as this
> selection is not used currently.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Applied to clk-next
