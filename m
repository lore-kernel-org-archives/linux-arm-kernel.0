From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 11 Jun 2010 11:07:23 +0200
Subject: [PATCH 10/11] USB: s3c-hsotg: Fix the OUT EP0 limit
In-Reply-To: <1276244457-4072-11-git-send-email-ben-linux@fluff.org>
References: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
	<1276244457-4072-11-git-send-email-ben-linux@fluff.org>
Message-ID: <006901cb0945$842a9e10$8c7fda30$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, June 11, 2010 10:21 AM Ben Dooks wrote:

> The EP0 out limit is the same as the IN limit, so make them the same.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> tmp-fix

^ looks like this temporary fix managed to get into the final patch series
without proper cleanup.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
