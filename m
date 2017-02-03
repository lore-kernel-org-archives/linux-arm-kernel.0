From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 3 Feb 2017 10:10:43 +0100
Subject: [PATCH v2 00/10] serial: st-asc: Allow handling of RTS line
In-Reply-To: <20170201143145.31962-1-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
Message-ID: <20170203091043.GA10386@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 02:31:35PM +0000, Lee Jones wrote:
> When hardware flow-control is disabled, manual toggling of the UART's
> reset line (RTS) using userland applications (e.g. stty) is not
> possible, since the ASC IP does not provide this functionality in the
> same was as some other IPs do.  Thus, we have to do this manually.
> 
> This set ensures the correct Pinctrl groups are configured and
> obtained for both manual toggling of the RTS line and for the IP to
> take over the lines when HW flow-control is requested by the user.

I see 2 series that are listed as "v2", which one to take?

I know, I'll drop both and wait for an updated set with all of the acks
added to them...

Please fix up and resend.

thanks,

greg k-h
