From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Oct 2018 17:12:19 -0500
Subject: [PATCH i2c-next v7 3/5] dt-bindings: i2c: aspeed: Add
 'bus-timeout-ms' property as an optional property
In-Reply-To: <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181011221219.GA31991@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  5 Oct 2018 14:45:05 -0700, Jae Hyun Yoo wrote:
> This commit adds 'bus-timeout-ms' property as an optional property
> which can be used for setting the bus timeout value of an adapter.
> With this patch, the bus timeout value can be set through this
> property at the probing time of this module. Still the bus timeout
> value can be set by an I2C_TIMEOUT ioctl on cdev at runtime too.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
