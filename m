From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 17 Jan 2013 17:27:15 -0800
Subject: [GIT PULL v3] Fixes/cleanup for vt8500 serial
In-Reply-To: <1358363143-7154-1-git-send-email-linux@prisktech.co.nz>
References: <1358363143-7154-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130118012715.GA29023@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 08:05:39AM +1300, Tony Prisk wrote:
> Hi Greg,
> 
> This should be the final pull request for this series, unless there are
> other review comments. Changelog included.
> 
> v2:
> Restore the setting of vt8500_port->uart.uartclk which was dropped in v1.
> Corrected the return-on-fail of devm_request_and_ioremap to -EADDRNOTAVAIL.
> 
> v3:
> Corrected the commit message for patch 3
> 
> 
> The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:
> 
>   Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)
> 
> are available in the git repository at:
> 
>   git://server.prisktech.co.nz/git/linuxwmt.git tags/vt8500/serial-fixes

I don't take git pull requests for tiny stuff like this, sorry, only
patches through email.

But 2 of these patches had checkpatch issues, so I didn't take patches 3
and 4, please redo them.

thanks,

greg k-h
