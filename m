From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 6 Mar 2017 13:53:34 +0100
Subject: [PATCH 1/2] staging/vc04_services: initialize cache line size
 properly
In-Reply-To: <1488419978.20502.1.camel@crowfest.net>
References: <20170301225050.1298349-1-arnd@arndb.de>
 <1488419978.20502.1.camel@crowfest.net>
Message-ID: <20170306125334.GC26115@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 05:59:38PM -0800, Michael Zoran wrote:
> Hi Arnd,
> 
> I submitted a change which is in Linux-next now that makes the whole
> CACHE_LINE_SIZE macro meaningless.  It now always reads the size from
> the DT and errors out with -ENODEV if the property is missing.
> 
> I was going to submit a change to delete the macro completely, just
> never got to it.
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit
> /drivers/staging/vc04_services/interface?id=6cf1bf636a067eb308cb3a8322b
> 9d6b1844a075d

This should be in 4.11-rc1.

thanks,

greg k-h
