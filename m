From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Dec 2013 16:25:04 -0800
Subject: [PATCH] clean up cache handling in platform code
In-Reply-To: <alpine.LFD.2.10.1312051417560.31246@knanqh.ubzr>
References: <alpine.LFD.2.10.1312051417560.31246@knanqh.ubzr>
Message-ID: <20131212002504.GC21531@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 02:26:16PM -0500, Nicolas Pitre wrote:
> We have a handy macro to replace open coded __cpuc_flush_dcache_area(()
> and outer_clean_range() sequences. Let's use it. No functional change.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Applied to next/cleanup (with ARM: as prefix).


-Olof
