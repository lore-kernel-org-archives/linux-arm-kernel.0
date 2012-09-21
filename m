From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 21 Sep 2012 00:45:02 +0000 (UTC)
Subject: [PATCH 2/2] ARM: OMAP: hwmod: revise deassert sequence
In-Reply-To: <1345614150-25723-3-git-send-email-omar.luna@linaro.org>
References: <1345614150-25723-1-git-send-email-omar.luna@linaro.org>
 <1345614150-25723-3-git-send-email-omar.luna@linaro.org>
Message-ID: <alpine.DEB.2.00.1209210044300.6888@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, 22 Aug 2012, Omar Ramirez Luna wrote:

> For a reset sequence to complete cleanly, a module needs its
> associated clocks to be enabled, otherwise the timeout check
> in prcm code can print a false failure (failed to hardreset)
> that occurs because the clocks aren't powered ON and the status
> bit checked can't transition without them.
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

Queued for 3.7, with the same caveats mentioned regarding patch 1.


- Paul
