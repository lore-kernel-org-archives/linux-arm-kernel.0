From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 18 Dec 2012 21:39:44 +0300
Subject: [PATCH RESEND 3/6] clk: exynos: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <1355852048-23188-4-git-send-email-linux@prisktech.co.nz>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-4-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121218183944.GH5032@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 06:34:05AM +1300, Tony Prisk wrote:
> Resend to include mailing lists.
> 
> Replace IS_ERR_OR_NULL with IS_ERR on clk_get results.
> 

The original code is correct.  clk_get() can return NULL depending
on the .config.

regards,
dan carpenter
