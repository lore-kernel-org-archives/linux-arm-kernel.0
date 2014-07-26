From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 26 Jul 2014 13:12:40 -0700
Subject: [PATCH 5/5] platform: Make platform_bus device a platform device
In-Reply-To: <1406298233-27876-5-git-send-email-pawel.moll@arm.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-5-git-send-email-pawel.moll@arm.com>
Message-ID: <20140726201240.GB21870@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 03:23:53PM +0100, Pawel Moll wrote:
> ... describing the root of the device tree, so one can write
> a platform driver initializing the platform.

Wait, what do you mean by "one can write a platform driver initializing
the platform"?  I don't understand your end goal here...

thanks,

greg k-h
