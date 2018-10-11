From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Oct 2018 17:11:48 -0500
Subject: [PATCH i2c-next v7 1/5] dt-bindings: i2c: Add 'bus-timeout-ms'
 and '#retries' properties as common optional
In-Reply-To: <20181005214507.26315-2-jae.hyun.yoo@linux.intel.com>
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com>
 <20181005214507.26315-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181011221148.GA31195@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  5 Oct 2018 14:45:03 -0700, Jae Hyun Yoo wrote:
> This commit adds 'bus-timeout-ms' and '#retries' properties as
> common optional properties that can be used for setting 'timeout'
> and 'retries' values of 'struct i2c_adapter'. With this patch, the
> bus timeout value and the master transfer retries count can be set
> through these properties at the registration time of an adapter.
> Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
> on cdev at runtime too.
> 
> These properties may not be supported by all drivers. However, if
> a driver wants to support one of them, it should adapt the
> bindings in this document.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
