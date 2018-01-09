From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 9 Jan 2018 19:47:33 +0100
Subject: [PATCH V5 00/13] drivers: Boot Constraint core
In-Reply-To: <cover.1513264961.git.viresh.kumar@linaro.org>
References: <cover.1513264961.git.viresh.kumar@linaro.org>
Message-ID: <20180109184733.GB28273@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 09:03:07PM +0530, Viresh Kumar wrote:
> Hi Greg,
> 
> Here is V5 of the boot constraints core based on your feedback from V4.
> Hope this looks better now :)
> 
> I have tested the Hisilicon patches (again) on hikey 9660 board, IMX
> stuff was earlier tested by Sascha (Pengutronix) on i.MX6 and Qualcomm
> stuff was earlier tested by Rajendra (Qualcomm) on Dragonboard 410C
> (This required some more patches related to display driver which
> Rajendra should be sending separately later on).

Can you resend this?  As you can tell, I've been a bit busy for the past
month or so :(

And you had a few different versions of at least one of these patches,
which is messy.  Also, why is there no signed-off-by on the OF core
patches?

thanks,

greg k-h
