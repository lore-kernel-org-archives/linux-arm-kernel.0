From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 3 Jun 2013 19:09:54 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <20130603165753.GL3803@titan.lakedaemon.net>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603165753.GL3803@titan.lakedaemon.net>
Message-ID: <20130603190954.3bd52784@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Mon, 3 Jun 2013 12:57:53 -0400, Jason Cooper wrote:

> Won't this override a user editing the 'local-mac-address' property in
> the dts?  Since we're dealing with appended dtbs, there's a higher
> probability of the user doing such a thing.
> 
> I'll admit it's a corner case, but I'd like to make sure we've thought
> through the use cases and aren't making things more complicated than
> necessary.

I don't have a strong opinion about this one, so if it's seen as being
necessary to preserve a potentially existing 'local-mac-address', then
I'll add the necessary checks to only update the property if it doesn't
already exist.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
