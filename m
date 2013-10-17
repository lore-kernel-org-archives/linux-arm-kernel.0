From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Oct 2013 08:54:14 -0400
Subject: [PATCH] arm: plat-orion: remove deprecated IRQF_DISABLED
In-Reply-To: <1381549760-5432-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1381549760-5432-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <20131017125414.GB22434@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 12, 2013 at 05:49:20AM +0200, Michael Opdenacker wrote:
> This patch proposes to remove the use of the IRQF_DISABLED flag
> 
> It's a NOOP since 2.6.35 and it will be removed one day.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> ---
>  arch/arm/plat-orion/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/soc

thx,

Jason.
