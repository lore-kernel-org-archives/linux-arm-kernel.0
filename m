From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 18 Dec 2012 22:03:34 +0300
Subject: [PATCH RESEND 3/6] clk: exynos: Fix incorrect usage of
 IS_ERR_OR_NULL
In-Reply-To: <1355856767.23479.3.camel@gitbox>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
 <1355852048-23188-4-git-send-email-linux@prisktech.co.nz>
 <20121218183944.GH5032@mwanda> <1355856767.23479.3.camel@gitbox>
Message-ID: <20121218190334.GK5032@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't care either way, but being different from the documentation
is less bad than crashing which is what your patch does.  Please
be more careful in the future.

regards,
dan carpenter
