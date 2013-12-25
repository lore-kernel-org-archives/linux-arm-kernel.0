From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Dec 2013 20:47:15 -0500
Subject: [PATCH 3/3] ARM: mvebu: make armada_370_xp_pmsu_init() static
In-Reply-To: <1387788491-3168-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1387788491-3168-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131225014715.GG19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Mon, Dec 23, 2013 at 09:48:11AM +0100, Thomas Petazzoni wrote:
> The armada_370_xp_pmsu_init() function is called as an
> early_initcall(). Therefore, there is no need to export this function,
> and we can make it static.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/common.h | 1 -
>  arch/arm/mach-mvebu/pmsu.c   | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Thanks, but this was already cleaned up up by:

  b12634e343be ARM: mvebu: fix some sparse warnings

in mvebu/soc (it was actually HEAD up until a few moments ago ;-)

Ho, ho, ho,

Jason.
