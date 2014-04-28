From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 28 Apr 2014 08:55:29 +0200
Subject: [PATCH 1/6] drivers: net: cpts: Remove hardcoded clock name for
 CPTS
In-Reply-To: <1398658225-25873-2-git-send-email-george.cherian@ti.com>
References: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
 <1398658225-25873-2-git-send-email-george.cherian@ti.com>
Message-ID: <20140428065529.GA4380@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 09:40:20AM +0530, George Cherian wrote:
> CPTS refclk name is hardcoded, which makes it fail in case of DRA7x
> Remove the hardcoded clock name for CPTS refclk and get the same from DT.

Patch ordering - doesn't this patch depend on patch #2?

Thanks,
Richard
