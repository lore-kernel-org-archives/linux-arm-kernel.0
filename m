From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 3 Feb 2011 13:52:18 +0100
Subject: [PATCH 04/19] ab3100: mfd_cell is now implicitly available to
	drivers
In-Reply-To: <20110202200302.0e05c3d0@queued.net>
References: <20110202195417.228e2656@queued.net>
	<20110202200302.0e05c3d0@queued.net>
Message-ID: <4D4AA502.4000001@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2011 05:03 AM, Andres Salomon wrote:
> No need to explicitly set the cell's platform_data/data_size.
>
> In this case, move the ab3100_platform_data pointer from platform_data
> to driver_data.  The only client who makes use of it is also changed.
>
> Signed-off-by: Andres Salomon<dilinger@queued.net>
>    

Looks good, thanks Andres,
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
