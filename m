From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 17:31:11 -0400
Subject: [PATCH v3 7/7] arm: plat-orion: remove addr-map code
In-Reply-To: <1363885160-6870-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1363885160-6870-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130330213111.GB13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:59:20PM +0100, Thomas Petazzoni wrote:
> Now that all Marvell EBU platforms have been converted to use the
> mvebu-mbus driver, we can remove the common plat-orion/addr-map.c code
> that isn't compiled anymore.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/plat-orion/addr-map.c |  175 ----------------------------------------
>  1 file changed, 175 deletions(-)
>  delete mode 100644 arch/arm/plat-orion/addr-map.c

Patches 2-7 of this series applied to mvebu/soc

thx,

Jason.
