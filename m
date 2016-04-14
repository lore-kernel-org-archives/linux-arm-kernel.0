From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 14 Apr 2016 12:25:40 -0700
Subject: [PATCH v5 00/10] Support for Cortex-M Prototyping System
In-Reply-To: <570F593D.6040809@arm.com>
References: <1459519381-34441-1-git-send-email-vladimir.murzin@arm.com>
 <570F593D.6040809@arm.com>
Message-ID: <20160414192540.GD20512@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 09:47:57AM +0100, Vladimir Murzin wrote:
> Hi,
> 
> On 01/04/16 15:02, Vladimir Murzin wrote:
> > Hi,
> > 
> > This patch series provides the basic support for running ucLinux on V2M-MPS2
> > platform.
> > 
> > With these patches applied ucLinux can be run on both HW and FVP models
> > with Cortex-M3/M4/M7 configurations.
> 
> Any objection to get it merged?
> 
> Sudeep Holla noticed that there is merge conflict against linux-next
> with PIC32 uart (Makefile and serial_core.h), so should I provide
> conflict resolution or do rebase on someone's branch?
> 
> Anyway, I'd be glad to know how it should be processed further?

I have no objection to the tty/serial changes, so if this all goes
through the arm-soc tree, that's fine with me.

thanks,

greg k-h
