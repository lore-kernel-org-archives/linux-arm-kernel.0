From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2012 10:51:54 +0100
Subject: [PATCH v4] Network driver for the Armada 370 and Armada XP ARM
 Marvell SoCs
In-Reply-To: <1351245804-31478-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351245804-31478-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121030105154.5b7c8e48@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 26 Oct 2012 12:03:20 +0200, Thomas Petazzoni wrote:

> This patch set adds a new network driver for the network unit
> available in the newest Marvell ARM SoCs Armada 370 and Armada XP, as
> well as the necessary Device Tree information to use this driver in
> the two evaluation platforms of those SoCs.

Besides Nobuhiro's small comment on the Device Tree part, are there any
comments on the driver itself, or is the code good to go?

I can send a fifth version with just the fix for Nobuhiro's comment,
but it probably makes sense to take into account a few more comments
(if any) at the same time.

Thanks for your review,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
