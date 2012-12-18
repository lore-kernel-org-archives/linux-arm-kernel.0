From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 18 Dec 2012 21:42:56 +0300
Subject: [PATCH RESEND 0/6] Remove incorrect usage of IS_ERR_OR_NULL on
 clk_get
In-Reply-To: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
References: <1355852048-23188-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20121218184256.GI5032@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 06:34:02AM +1300, Tony Prisk wrote:
> Resend to include mailing lists.
> 
> As per the kernel docs, clk_get() cannot return NULL.
> 

It returns NULL if CONFIG_HAVE_CLK is disabled.

regards,
dan carpenter
