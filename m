From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 00:25:20 -0700
Subject: [PATCH 1/2] clk: mediatek: add devm_of_platform_populate() for
 MT7622 audsys
In-Reply-To: <004f07aef08148321c320ea09f8169982f73dd2b.1521514928.git.ryder.lee@mediatek.com>
References: <004f07aef08148321c320ea09f8169982f73dd2b.1521514928.git.ryder.lee@mediatek.com>
Message-ID: <152153072063.254778.14980520624689416670@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ryder Lee (2018-03-19 20:16:51)
> Add devm_of_platform_populate() to populate devices which are children
> of the root node.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

Applied to clk-next
