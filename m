From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Jun 2018 16:23:09 +0530
Subject: [PATCH] ARM: dts: da850: Add power-domains to PWM nodes
In-Reply-To: <20180626152817.16803-1-david@lechnology.com>
References: <20180626152817.16803-1-david@lechnology.com>
Message-ID: <52fe7982-9bee-1b45-a939-59ec5cff756d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 June 2018 08:58 PM, David Lechner wrote:
> This adds the power-domains property to both the ECAP and EHRPWM PWM
> nodes. Both have drivers that use pm_runtime to enable the clocks, so
> they need this property in order to find and enable the clock properly.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied for v4.19

Thanks,
Sekhar
