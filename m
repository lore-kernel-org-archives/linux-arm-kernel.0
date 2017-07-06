From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 6 Jul 2017 10:51:47 +0200
Subject: [PATCH 6/6] net: stmmac: revert "support future possible
 different internal phy mode"
In-Reply-To: <20170702123159.6939-7-clabbe.montjoie@gmail.com>
References: <20170702123159.6939-1-clabbe.montjoie@gmail.com>
 <20170702123159.6939-7-clabbe.montjoie@gmail.com>
Message-ID: <20170706085147.GA15728@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 02, 2017 at 02:31:59PM +0200, Corentin Labbe wrote:
> Since internal phy-mode is reserved for non-xMII protocol we cannot use
> it with dwmac-sun8i
> This reverts commit 1c2fa5f84683 ("net: stmmac: support future possible different internal phy mode")
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---

Hello

This patch was left not applied but all other patch from this serie was.
Could you apply it, or perhaps you prefer I resend it with some "Fixes:"

Regards
Corentin Labbe
