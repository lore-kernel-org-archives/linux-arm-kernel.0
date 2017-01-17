From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Jan 2017 10:00:39 +0100
Subject: [PATCH] ARM: shmobile: r8a7779: marzen: Fix sata device status
In-Reply-To: <1484585813-22534-1-git-send-email-geert+renesas@glider.be>
References: <1484585813-22534-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170117090038.GA7960@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 05:56:53PM +0100, Geert Uytterhoeven wrote:
> Device nodes representing I/O devices should be marked disabled in the
> SoC-specific DTS, and overridden by board-specific DTSes where needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.11.
