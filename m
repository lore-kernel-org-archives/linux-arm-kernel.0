From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 27 Feb 2014 19:07:15 +0530
Subject: [PATCH 0/5] ARM: davinci: tnetv107x removal
In-Reply-To: <1393418614-3968549-1-git-send-email-arnd@arndb.de>
References: <1393418614-3968549-1-git-send-email-arnd@arndb.de>
Message-ID: <530F3F8B.4090509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(fixed Cyril's e-mail address)

On Wednesday 26 February 2014 06:13 PM, Arnd Bergmann wrote:
> This series removes the TI davinci/tnetv107x platform that
> has evidently bitrotted to the point where it's completely
> useless. While we could probably fix it and add a defconfig,
> it appears that there are actually no users of this platform,
> and it complicates the davinci code base because it's
> incompatible with all the other SoCs in there that are
> based on ARM926T.
> 
> The five patches are completely independent of one another,
> and applying them out of order is fine since we just want
> to remove the code. However, I'm looking for an Ack from
> Cyril Chemparathy and Sekhar Nori first, to be sure we
> won't need this code in the future. Kevin Hilman has
> already mentioned that he sees no reason to keep this
> code.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Regards,
Sekhar
