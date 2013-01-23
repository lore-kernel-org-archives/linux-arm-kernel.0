From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 23 Jan 2013 10:56:08 +0100
Subject: [PATCH 1/2] i2c: sirf: register i2c_client from dt child-nodes
 in probe entry
In-Reply-To: <1356489017-17737-1-git-send-email-Barry.Song@csr.com>
References: <1356489017-17737-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20130123095608.GC3767@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 26, 2012 at 10:30:16AM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> in probe() entry of i2c_driver, set the of node of adapter and
> call of_i2c_register_devices to register all i2c_client from
> dt child-nodes
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, applied to for-current.
