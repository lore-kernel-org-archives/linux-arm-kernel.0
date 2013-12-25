From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Dec 2013 20:51:20 -0500
Subject: [PATCH 1/3] ARM: mvebu: move ARMADA_XP_MAX_CPUS to armada-370-xp.h
In-Reply-To: <1387788491-3168-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1387788491-3168-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131225015120.GH19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 09:48:09AM +0100, Thomas Petazzoni wrote:
> The ARMADA_XP_MAX_CPUS definition was in common.h, which as its name
> says, is common to all mvebu SoCs. It is more logical to have this XP
> specific definition in the already existing armada-370-xp.h header
> file, especially in preparation to the addition of the support for
> other SOCs in mach-mvebu.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.h | 2 ++
>  arch/arm/mach-mvebu/common.h        | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/soc

thx,

Jason.
