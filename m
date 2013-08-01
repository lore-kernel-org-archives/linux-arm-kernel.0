From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 1 Aug 2013 17:54:10 +0200
Subject: [PATCH 0/9] ARM: kirkwood: convert a few more boards to DT
In-Reply-To: <20130801154821.GG19725@lunn.ch>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130801154821.GG19725@lunn.ch>
Message-ID: <20130801175410.2d738b43@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 1 Aug 2013 17:48:21 +0200, Andrew Lunn wrote:

> > Here is a set of patches that converts a few additional Kirkwood
> > boards to use the Device Tree. I intend to continue this effort with
> > the remaining Kirkwood boards.
> 
> Hi Thomas
> 
> I think it would be good to leave one board that somebody has with
> both DT and old style startup, for one or two cycles. 
> 
> I used to regularly test both on my QNAP, but its currently in a
> container heading west, and i will not have access to it for a couple
> of months. Is there another board we can pick which somebody has?

For now, the HP t5325 has not been converted to DT (I'm working on the
patches, but I have issues with audio), and I have the platform here.

My goal is to convert all boards for 3.12, so that I could do the
clean up of MPP, PCIe and other related stuff. I don't know if I'll
achieve that, but if not, we can always put back the Guruplug legacy
support, for example.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
