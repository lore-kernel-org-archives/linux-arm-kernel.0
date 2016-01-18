From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Jan 2016 10:45:28 +0900
Subject: [PATCH 2/3] ARM: shmobile: timer: Drop support for Cortex A8
In-Reply-To: <1452537674-20006-3-git-send-email-geert+renesas@glider.be>
References: <1452537674-20006-1-git-send-email-geert+renesas@glider.be>
 <1452537674-20006-3-git-send-email-geert+renesas@glider.be>
Message-ID: <20160118014528.GE1905@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 07:41:13PM +0100, Geert Uytterhoeven wrote:
> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy
> file") removed the DTS for the last shmobile SoC with a Cortex A8 CPU
> core (sh7372 aka SH-Mobile AP4).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.6.
