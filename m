From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Apr 2018 17:53:18 +0300
Subject: [PATCH 1/8] arm: shmobile: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <1524230914-10175-2-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
 <1524230914-10175-2-git-send-email-geert+renesas@glider.be>
Message-ID: <44b6b9a3-5273-54f4-ee72-0d5fcc36348a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2018 04:28 PM, Geert Uytterhoeven wrote:

> Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
> is ARCH_RENESAS a more appropriate platform dependency than the legacy

   "ARCH_RENESAS is", no?

> ARCH_SHMOBILE, hence use the former.
> 
> This will allow to drop ARCH_SHMOBILE on ARM in the near future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergei
