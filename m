From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 4 Apr 2013 11:29:08 +0200
Subject: [RFCv1 00/11] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130404091639.GA2245@localhost>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130404091639.GA2245@localhost>
Message-ID: <20130404112908.24c25c9a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Thu, 4 Apr 2013 06:16:40 -0300, Ezequiel Garcia wrote:

> Given the IRQ controller move to drivers/irqchip is independent of MSI
> work, and that we've already agreed this move is fine (Arnd has acked
> patch 2), may I suggest that you resend these three first patches
> (and perhaps the fourth?) as a separate patchset to be included in v3.10.
> 
> This has the advantage that further development on IRQ controller can be
> done directly on its proper place, and also the MSI patchset can be
> simplified.
> 
> What do you think?

Sounds like a good idea. I'll cook a patch set later today and I'll
send it.

Thanks for the suggestion!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
