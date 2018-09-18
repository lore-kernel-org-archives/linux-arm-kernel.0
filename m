From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 18 Sep 2018 11:02:54 -0700
Subject: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' setting
In-Reply-To: <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
 <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <a81a6092-a9d0-78d5-3596-cddc5d6a0713@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/10/2018 2:45 PM, Jae Hyun Yoo wrote:
> +- idle-wait-timeout-ms	: bus idle waiting timeout in milliseconds when
> +			  multi-master is set, defaults to 100 ms when not
> +			  specified.

Will change it to 'aspeed,idle-wait-timeout-ms' as it's a non standard
property.

Jae
