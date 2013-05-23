From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 01:17:24 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130523230911.GR18614@n2100.arm.linux.org.uk>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130523142301.10dbeff9@skate>
 <20130523202643.GQ18614@n2100.arm.linux.org.uk>
 <201305232240.03959.arnd@arndb.de>
 <20130523230911.GR18614@n2100.arm.linux.org.uk>
Message-ID: <20130524011724.515eac91@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, 24 May 2013 00:09:11 +0100, Russell King - ARM Linux wrote:

> No, I'm not asking about the principle.  I'm asking _in this particular
> problem case_ who provides the DT blob?
> 
> So the person to answer that question is Thomas or someone who is using
> the boards concerned.

The DTB is built from arch/arm/boot/dts/, together with the kernel
image itself. As far as I'm aware of, there is for the moment no plan
to "burn" the DTB on the board and therefore make the Device Tree
really separated from the kernel.

Does that answer your question? If not, do not hesitate to ask for
further details.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
