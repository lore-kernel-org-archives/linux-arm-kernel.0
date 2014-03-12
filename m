From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 12 Mar 2014 12:35:24 +0100
Subject: [PATCH 0/2] ARM: add initial support for the Marvell BG2-Q DMP
In-Reply-To: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140312113523.GL13905@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/03/2014 at 12:06:02 +0100, Antoine T?nart wrote :
> This serie adds the initial support for the Marvell BG2-Q DMP (part of the
> Berlin family). SoC has nodes for cpu, l2 cache controller, interrupt
> controllers, local timer, apb timers and uarts for now.
> 
> Homepage: http://www.marvell.com/digital-entertainment/armada-1500-pro/
> 

I would move that description to the commit logs. Else one would have to
lookup the mailing list archive to read it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
