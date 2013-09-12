From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 12 Sep 2013 16:39:15 +0100
Subject: [linux-sunxi] Re: [PATCH 3/4] Add physical count arch timer
 support for clocksource in ARMv7.
In-Reply-To: <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
Message-ID: <1379000355.10076.75.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 12:24 +0100, Mark Rutland wrote:
> 
> Why can the bootloader not be fixed to set CNTVOFF (or to boot the
> kernel in Hyp mode)? 

It can:
http://lists.xen.org/archives/html/xen-devel/2013-09/msg00880.html

I was waiting for Andre's hyp mode u-boot patches to land before posting
the sunxi bits on top. I'm not sure what the status of that is.

Ian.
