From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Dec 2014 09:30:52 +0900
Subject: [PATCH 1/7] ARM: shmobile: genmai dts: Replace status value "ok"
 by "okay"
In-Reply-To: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
References: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20141210003051.GG9690@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 12:24:59PM +0100, Geert Uytterhoeven wrote:
> While the DT parsing code recognizes "ok" as a valid value for the
> "status" property, ePAPR v1.1 doesn't mention it in the list of valid
> values.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued up this and the other 6 patches.
