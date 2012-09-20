From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Sep 2012 16:58:58 +0100
Subject: [RFC PATCH 13/13] Documentation: add schedule for removing
 private EDMA API
In-Reply-To: <1348152226-13588-14-git-send-email-mporter@ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-14-git-send-email-mporter@ti.com>
Message-ID: <20120920155858.GA4583@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 10:43:46AM -0400, Matt Porter wrote:

>  Documentation/feature-removal-schedule.txt |   10 ++++++++++
>  1 file changed, 10 insertions(+)

We decided at kernel summit that we'd stop bothering with this, it's
mostly just bitrot and rarely read.  I guess the ASoC driver update
isn't ready yet?
