From: richard.zhao@linaro.org (Richard Zhao)
Date: Sat, 15 Oct 2011 10:34:30 +0800
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <20111015022448.GA17872@b20223-02.ap.freescale.net>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<CAJOA=zM9k7_z_PUoF0tZ_OrgdDTgMjZLftqtW0ra3G9C08Th7g@mail.gmail.com>
	<20111015022448.GA17872@b20223-02.ap.freescale.net>
Message-ID: <20111015023428.GA18134@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  - When I define a clk array, I don't need to find another place to store .ops.
                                  ^^^^^
remove "don't". sorry for that.
 
