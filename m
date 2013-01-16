From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 15 Jan 2013 22:57:47 -0800
Subject: [PATCH 4/4] serial: tty: Cleanup code using devm_ function
In-Reply-To: <1358225886-5686-5-git-send-email-linux@prisktech.co.nz>
References: <1358225886-5686-1-git-send-email-linux@prisktech.co.nz>
 <1358225886-5686-5-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130116065747.GA20126@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 05:58:06PM +1300, Tony Prisk wrote:
> Convert the last memory allocation (vt8500_port) to use devm_kzalloc
> and remove the fail path cleanup code from vt8500_serial_probe.
> 
> Reorder iomem mapping above clk_enable to simplify fail code. The
> clock is only enabled if all other resources are available.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

You've send a few different versions of this patch, with no indication
as to what changed, or what one I should take.  Care to send me the
correct one?

thanks,

greg k-h
