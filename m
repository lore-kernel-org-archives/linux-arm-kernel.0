From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 20:29:50 +0100
Subject: [GIT PULL] Samsung devel-2 for v3.2
In-Reply-To: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
References: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
Message-ID: <20111002192950.GB1005@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 06:25:36PM +0900, Kukjin Kim wrote:

>       gpio/samsung: gpio-samsung.c to support Samsung GPIOs

As I reported the other day this change breaks the boot early on on the
Cragganmore S3C6410 based systems (I've not actually fired up my
SMDK6410 but I suspect it may have issues too).  I did make some brief
attempts to debug but as there's no console output at all and the diff
is rather large it's not easy to see what's gone wrong.
