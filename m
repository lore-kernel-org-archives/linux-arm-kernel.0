From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 14:04:23 -0700
Subject: [PATCH 05/61] clk: samsung: simplify getting .drvdata
In-Reply-To: <93ee0d94-81aa-db81-2bff-87f5f91bc9d3@samsung.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
 <CGME20180515093219epcas1p28a5fa4be53b9ea0fd85e4726cf92f804@epcas1p2.samsung.com>
 <93ee0d94-81aa-db81-2bff-87f5f91bc9d3@samsung.com>
Message-ID: <152641826350.237094.15477833672849994762@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2018-05-15 02:32:12)
> On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> > We should get drvdata from struct device directly. Going via
> > platform_device is an unneeded step back and forth.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> It seems to be the only clk/samsung patch in the v4.18 queue, please
> feel free to apply it directly.

Ok. I'll pick it up.
