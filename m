From: greg@kroah.com (Greg KH)
Date: Sat, 26 Nov 2011 19:36:42 -0800
Subject: [PATCH v2 0/4] OMAP serial device tree support
In-Reply-To: <1321969456-24266-1-git-send-email-rnayak@ti.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com>
Message-ID: <20111127033642.GA28378@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 07:14:12PM +0530, Rajendra Nayak wrote:
> v2 is based on the latest omap-serial runtime patches, which
> can be found here[1]
> 
> The series passes minimal data that allows serial console
> boot, with UART's initialised from device tree.
> However some of low power support for UART and remote
> wakeup needs more work.
> Boot tested on OMAP4 panda and OMAP4 sdp boards.
> 
> Patches can be found here..
> git://gitorious.org/omap-pm/linux.git for-dt/serial

What tree are these going to go through, some device tree one, or do you
want me to take the serial driver patches?

thanks,

greg k-h
