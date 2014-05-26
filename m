From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 May 2014 12:10:09 -0700
Subject: [PATCH] clk: samsung: clk-s3c2410-dlck: do not use PNAME macro
 as it declares __initdata
In-Reply-To: <4598341.WkbLY9yLfe@phil>
References: <4598341.WkbLY9yLfe@phil>
Message-ID: <20140526191009.GC27093@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 10:58:53PM +0200, Heiko St?bner wrote:
> The originally used PNAME macro from the core samsung clock infrastructure
> declares the created array as initdata, creating section mismatch warnings
> in the dclk driver.
> 
> Thus declare them directly, removing these warning.
> 
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> This should probably go though the samsung tree / arm-soc, as the
> offending patch is also in there.

Applied on top of next/cleanup.


-Olof
