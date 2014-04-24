From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Apr 2014 01:51:47 -0400
Subject: [PATCH v3 00/11] SMP support for Armada 375 and 38x
In-Reply-To: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140424055147.GX28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 03:53:57PM +0200, Thomas Petazzoni wrote:
> Jason, Andrew, Gregory, Sebastian,
> 
> This patch series adds SMP support for the Armada 375 and 38x. Read
> the bottom of the e-mail for details about the patches. Note that this
> patch series applies on *top* of the 375/38x coherency and PMSU rework
> series.

Patches 4 and 5 applied to mvebu/irqchip, while 3, 10, and 11 go to
mvebu/dt.  All others go to mvebu/soc.  mvebu/irqchip is pulled in as a
dep of mvebu/soc.

thx,

Jason.
