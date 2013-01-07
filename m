From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Jan 2013 18:10:22 +0100
Subject: [PATCH 3.8-rc] arm: mvebu: add LEDs support to defconfig file
In-Reply-To: <20130107170450.GK5075@titan.lakedaemon.net>
References: <1357576034-24193-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130107170450.GK5075@titan.lakedaemon.net>
Message-ID: <20130107181022.6c5f892e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Mon, 7 Jan 2013 12:04:50 -0500, Jason Cooper wrote:
> On Mon, Jan 07, 2013 at 05:27:14PM +0100, Thomas Petazzoni wrote:
> > The OpenBlocks AX3-4 platform has several LEDs, so it sounds wise to
> > enable LED support in mvebu_defconfig. We anticipate that more
> > platforms using Marvell EBU SoCs will have LEDs in the future.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> > This is 3.8-rc material.
> 
> Is this patch fixing a problem?  I'm inclined to queue this up for 3.9

Well, it's just a defconfig update, and I think defconfig updates are
generally accepted during the -rc cycle.

Otherwise, I'm fine if it waits until 3.9.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
