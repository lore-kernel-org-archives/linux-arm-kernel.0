From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 11 Sep 2018 16:04:00 +0200
Subject: [GIT PULL v2] Immutable branch between MFD, SPI and TTY due for
 the v4.20 merge window
In-Reply-To: <20180911111850.GJ4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911111850.GJ4185@dell>
Message-ID: <20180911140400.GB18410@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 12:18:50PM +0100, Lee Jones wrote:
> [In case you missed it]
> 
> This new pull-request contains the following changes since v1:
> 
>  - Uplift the submission version from v11 to v12
>  - Include fix for build breakage due to missing Device Tree include file
> 
> Since it is based on the original pull-request, it can be pulled
> in either directly on top of it or as a pull in its own right.
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20-1

Ok, let's try this again, I've dropped that other patch and taken this
branch into my tree.

Hopefully this all works well :)

thanks,

greg k-h
