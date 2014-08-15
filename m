From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Aug 2014 15:23:52 +0100
Subject: [PATCH 10/10 v3] ARM: removing support for etb/etm in
 "arch/arm/kernel/"
In-Reply-To: <1407435706-19441-11-git-send-email-mathieu.poirier@linaro.org>
References: <1407435706-19441-1-git-send-email-mathieu.poirier@linaro.org>
 <1407435706-19441-11-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20140815142352.GU27466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 07:21:46PM +0100, mathieu.poirier at linaro.org wrote:
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Removing minimal support for etb/etm to favour an implentation
> that is more flexible, extensible and capable of handling more
> platforms.
> 
> Also removing the only client of the old driver.  That code can
> easily be replaced by entries for etb/etm in the device tree.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
