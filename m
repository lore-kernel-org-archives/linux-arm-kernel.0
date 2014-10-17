From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 17 Oct 2014 09:31:09 -0700
Subject: [PATCH 2/2] mtd: spi-nor: make spi_nor_scan() take a chip type
 name, not spi_device_id
In-Reply-To: <1411984074-3850-2-git-send-email-zajec5@gmail.com>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
 <1411984074-3850-2-git-send-email-zajec5@gmail.com>
Message-ID: <20141017163109.GI22169@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 11:47:54AM +0200, Rafa? Mi?ecki wrote:
> From: Ben Hutchings <ben@decadent.org.uk>
> 
> Drivers currently call spi_nor_match_id() and then spi_nor_scan().
> This adds a dependency on struct spi_device_id which we want to
> avoid.  Make spi_nor_scan() do it for them.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Pushed to l2-mtd.git/master.

Brian
