From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 22:41:50 -0600
Subject: [PATCH 01/10] spi: s3c64xx: remove unused S3C64XX_SPI_ST_TRLCNTZ
 macro
In-Reply-To: <1336514694-22393-2-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120520044150.634053E03B8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 09 May 2012 03:34:45 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> The macro S3C64XX_SPI_ST_TRLCNTZ is not used and hence it is removed.
> 
> Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Since this series has dependencies, I'm fine with it going via another
tree.

g.
