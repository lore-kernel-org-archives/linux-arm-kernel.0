From: peda@axentia.se (Peter Rosin)
Date: Thu, 20 Sep 2018 19:26:21 +0200
Subject: [RFC PATCH 2/4] i2c: core: remove level of indentation in
 i2c_transfer
In-Reply-To: <20180920161423.13990-3-wsa+renesas@sang-engineering.com>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-3-wsa+renesas@sang-engineering.com>
Message-ID: <c7ee2547-1b3b-3e43-e933-234516031770@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-09-20 18:14, Wolfram Sang wrote:
> Using the common kernel pattern to bail out at the beginning if some
> conditions are not met, we can save a level of indentation. No
> functional change.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Yes please!

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
