From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 23:20:07 -0500
Subject: [RFC/PATCH v2] ARM: mvebu: Rename the ARCH_MVEBU menu option
In-Reply-To: <1392920614-4372-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392920614-4372-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140222042007.GV7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 03:23:34PM -0300, Ezequiel Garcia wrote:
> The previous name "Marvell SOCs with Device Tree support" is a bit
> ambiguous and not too informative for users. Instead, use a more
> appropriate name.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Here's a second attempt, changing also the variant menu,
> which I forgot in v1. This (as v1) is mostly inspired in the Berlin
> menu config, so to keep some consistency.
> 
> Andrew: I didn't add your Acked-by, in case you don't agree with
> the new change. Feel free to ack or comment.
> 
>  arch/arm/mach-mvebu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/soc

thx,

Jason.
