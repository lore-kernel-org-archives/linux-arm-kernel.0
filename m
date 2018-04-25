From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Apr 2018 14:49:52 +0200
Subject: [PATCH 05/61] clk: samsung: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <CGME20180419140651epcas5p22119a061c760dd54c0c3e630b053ec1b@epcas5p2.samsung.com>
 <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
Message-ID: <215c52b1-3044-8dd9-c021-dc2b8ff78afe@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied, thanks!
