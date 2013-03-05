From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 19:39:00 +0000
Subject: [PATCH v2 00/12] ARM: mxs: move to generic DMA device tree binding
In-Reply-To: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201303051939.00808.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Shawn Guo wrote:
> The series converts mxs-dma and its clients to generic DMA device tree
> binding/helper.
> 
> I published a branch below to ease people who is willing to help
> testing the series.

Looks all good, aside from the bug I found in the first patch.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
