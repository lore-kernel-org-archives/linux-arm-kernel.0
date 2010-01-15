From: greg@kroah.com (Greg KH)
Date: Thu, 14 Jan 2010 16:24:19 -0800
Subject: [PATCH] staging/dream: add missing include files/fix compilation
In-Reply-To: <20091225205917.GA25761@elf.ucw.cz>
References: <20091225205917.GA25761@elf.ucw.cz>
Message-ID: <20100115002419.GA25643@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 25, 2009 at 09:59:18PM +0100, Pavel Machek wrote:
> This adds missing include files, so it should now compile. ifdef
> guards were added to Kconfig, so it should not cause problems on
> non-arch-msm machines.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Odd, this doesn't apply to the linux-next tree, some of the files are
already there.

Care to refresh this?

thanks,

greg k-h
