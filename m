From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 16:44:43 -0400
Subject: [PATCH] ARM: mvebu: mark armada_370_xp_pmsu_idle_prepare() as
 static
In-Reply-To: <1401116474-31221-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401116474-31221-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140620204443.GK21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 05:01:14PM +0200, Thomas Petazzoni wrote:
> The armada_370_xp_pmsu_idle_prepare() function is only used internally
> to pmsu.c, so there's no reason to not use the static qualifier.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/pmsu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/soc with Gregory's Ack.

thx,

Jason.
