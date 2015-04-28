From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Apr 2015 09:48:28 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7740 dtsi: Fix SCIFB naming
In-Reply-To: <1430142924-15777-1-git-send-email-geert+renesas@glider.be>
References: <1430142924-15777-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150428004827.GA557@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 03:55:23PM +0200, Geert Uytterhoeven wrote:
> The single SCIFB on R-Mobile A1 is called "scifb", not "scifb8".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Cfr. commit 0b3a0ef613538cae ("ARM: shmobile: r8a73a4: fix scifb* naming")

Thanks, both patches queued up for v4.2.
