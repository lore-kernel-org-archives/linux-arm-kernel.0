From: greg@kroah.com (Greg KH)
Date: Tue, 22 Nov 2011 07:42:59 -0800
Subject: [PATCH v3 0/5] common clk framework
In-Reply-To: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
Message-ID: <20111122154259.GA18954@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 05:40:42PM -0800, Mike Turquette wrote:
>   .sysfs support.  Visualize your clk tree at /sys/clk!  Where would be
> a better place to put the clk tree besides the root of /sys/?

Um, in the "proper" place for it under /sys/devices like the rest of the
device tree is?

> When a consensus on this is reached I'll submit the proper changes to
> Documentation/ABI/testing/.

I would like to see this documentation now, as it explains what you are
trying to do with the userspace api.

More comments on your sysfs patch...

thanks,

greg k-h
