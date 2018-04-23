From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Apr 2018 09:50:02 +0200
Subject: [PATCH 1/8] arm: shmobile: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <44b6b9a3-5273-54f4-ee72-0d5fcc36348a@cogentembedded.com>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-2-git-send-email-geert+renesas@glider.be>
 <44b6b9a3-5273-54f4-ee72-0d5fcc36348a@cogentembedded.com>
Message-ID: <20180423075002.bca27fbpffl5sbnc@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 05:53:18PM +0300, Sergei Shtylyov wrote:
> On 04/20/2018 04:28 PM, Geert Uytterhoeven wrote:
> 
> > Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> > is ARCH_RENESAS a more appropriate platform dependency than the legacy
> 
>    "ARCH_RENESAS is", no?

Thanks, applied with that corrected.

> 
> > ARCH_SHMOBILE, hence use the former.
> > 
> > This will allow to drop ARCH_SHMOBILE on ARM in the near future.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [...]
> 
> MBR, Sergei
> 
