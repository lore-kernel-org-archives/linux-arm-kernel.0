From: greg@kroah.com (Greg KH)
Date: Fri, 8 Jul 2011 22:38:18 -0700
Subject: [RFC PATCH v2 2/4] Core device subsystem implementation
In-Reply-To: <1310115250-3859-3-git-send-email-marc.zyngier@arm.com>
References: <1310115250-3859-1-git-send-email-marc.zyngier@arm.com>
	<1310115250-3859-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110709053818.GA14519@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 09:54:08AM +0100, Marc Zyngier wrote:
> There is a small number of devices that the core kernel needs very
> early in the boot process, namely an interrupt controller and a timer,
> long before the device model is up and running.
> 
> The "core device subsystem" offers a class based device/driver
> matching model, doesn't rely on any other subsystem, is very (too?)
> simple, and support getting information both from DT as well as from
> static data provided by the platform. It also gives the opportunity to
> define the probing order by offering a sorting hook at runtime.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Any reason why you didn't use scripts/get_maintainer.pl to at least
figure out who to send something like this to for review?

Please do so in the future, otherwise it will get overlooked...

greg k-h
