From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 21 Sep 2017 22:53:56 +0530
Subject: [PATCH v2] dmaengine: sun6i: use of_device_get_match_data
In-Reply-To: <20170920072402.27704-1-clabbe.montjoie@gmail.com>
References: <20170920072402.27704-1-clabbe.montjoie@gmail.com>
Message-ID: <20170921172356.GK30097@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 09:24:02AM +0200, Corentin Labbe wrote:
> The usage of of_device_get_match_data reduce the code size a bit.
> Furthermore, it prevents an improbable dereference when
> of_match_device() return NULL.

Applied, thanks

-- 
~Vinod
