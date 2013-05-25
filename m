From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 25 May 2013 05:22:40 -0700
Subject: [PATCH] module: use a macro instead of platform_driver_register
In-Reply-To: <51A040D2.20708@huawei.com>
References: <51A040D2.20708@huawei.com>
Message-ID: <20130525122240.GC3746@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 12:40:50PM +0800, Libo Chen wrote:
> 
> I found a lot of mistakes using struct platform_driver without owner
> so I make a macro instead of the function platform_driver_register.
> It can set owner in it, then guys don`t care about module owner again.
> 
> Signed-off-by: Libo Chen <libo.chen@huawei.com>

Nice job, that's the better way to fix this, I'll queue it up for 3.11.

thanks,

greg k-h
