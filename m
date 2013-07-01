From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 1 Jul 2013 16:33:01 +0200
Subject: v3.10 - big endian core support
In-Reply-To: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130701163301.7c1228df@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ben Dooks,

On Mon,  1 Jul 2013 12:03:58 +0100, Ben Dooks wrote:
> The latest big-endian changes, now on:
> 
> 	git://git.baserock.org/delta/linux baserock/311/be/core
> 
> This has a minor fix from the last version where a rebase missed a change
> in the smp_scu code.

Patches 1, 2, 3, 4 and 9:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

on an Armada XP GP board. The other patches are not exercised by this
particular testing.

I'm interested in seeing this series merged.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
