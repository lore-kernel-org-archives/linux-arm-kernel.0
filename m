From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 11:46:52 -0700
Subject: [PATCH v3 3/5] clk: actions: Add REGMAP as dependency
In-Reply-To: <20180703092524.1697111-4-sravanhome@gmail.com>
References: <20180703092524.1697111-1-sravanhome@gmail.com>
 <20180703092524.1697111-4-sravanhome@gmail.com>
Message-ID: <153090281264.143105.2922773144286373098@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Saravanan Sekar (2018-07-03 02:25:22)
> Add REGMAP as dependency to avoid undefined reference to regmap symbol
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

Fixes tag? This should come earlier in the series, or even at the
beginning.
