From: greg@kroah.com (Greg KH)
Date: Mon, 8 Apr 2013 09:42:09 -0700
Subject: [PATCH V5 0/6] USB: EHCI multiplatform for 3.10
In-Reply-To: <1364919844-1726-1-git-send-email-arnd@arndb.de>
References: <1364919844-1726-1-git-send-email-arnd@arndb.de>
Message-ID: <20130408164209.GA13694@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 06:23:58PM +0200, Arnd Bergmann wrote:
> Hi Greg,
> 
> Here are the EHCI patches that I think are good for inclusion in 3.10,
> I hope you are willing to include them after the debacle over these
> patches in 3.9.
> 
> The patches are all logically independent but sorted by priority,
> so decide for yourself how many you want to take, starting at the
> first one. The first six patches all have an Ack from Alan Stern
> and from the respective ARM platform maintainers.

I don't see an ACK for the 6th patch from Alan, any reason for that?

I've applied the first 5 for now, if you want the 6th one applied,
please resend.

thanks,

greg k-h
