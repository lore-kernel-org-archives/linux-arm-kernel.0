From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Thu, 18 Aug 2011 13:19:28 +0300 (EEST)
Subject: [PATCH 5/7] omap: iovmm: remove unused functionality
In-Reply-To: <1313622608-30397-6-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-6-git-send-email-ohad@wizery.com>
Message-ID: <20110818.131928.751866371806910622.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 5/7] omap: iovmm: remove unused functionality
Date: Thu, 18 Aug 2011 02:10:06 +0300

> Remove unused functionality from OMAP's iovmm module.
> 
> The intention is to eventually completely replace iovmm with the
> generic DMA-API, so new code that'd need this iovmm functionality
> will have to extend the DMA-API instead.

Maybe it's better to remove the comments explaining unnecessary
functions too. Now the function comparison table doesn't make sense....
