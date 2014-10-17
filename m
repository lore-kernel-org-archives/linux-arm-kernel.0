From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 17 Oct 2014 09:30:23 -0700
Subject: [PATCH 1/2] mtd: m25p80: get rid of spi_get_device_id
In-Reply-To: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
Message-ID: <20141017163023.GH22169@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 11:47:53AM +0200, Rafa? Mi?ecki wrote:
> This simplifies the way we use spi_nor framework and will allow us to
> drop spi_nor_match_id.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Applied to l2-mtd.git/master.

Brian
