From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 15 Feb 2013 16:56:40 -0500
Subject: [PATCH v2 3/5] arm: mvebu: update defconfig with local timer
 support
In-Reply-To: <1359135165-32108-4-git-send-email-gregory.clement@free-electrons.com>
References: <1359135165-32108-1-git-send-email-gregory.clement@free-electrons.com>
 <1359135165-32108-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130215215640.GI14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 06:32:43PM +0100, Gregory CLEMENT wrote:
> Now that we have support for local timers, enable it by default
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig |    1 -
>  1 file changed, 1 deletion(-)

Applied patches 1, 2, and 3 of this series to mvebu/boards.  In the
future, please put driver changes first (patch #2) with few if any
dependencies.

In this case, since these patches depended on SMP support added to
mvebu/boards, I had to apply them to mvebu/boards to prevent a circular
dependency.

thx,

Jason.
