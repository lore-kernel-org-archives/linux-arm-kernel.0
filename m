From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 06 Aug 2013 09:13:01 +0200
Subject: [RFC PATCH v2 0/3] ARM: TC2 big.LITTLE CPU idle driver
In-Reply-To: <1375709982-27148-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1375709982-27148-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5200A1FD.6050709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 03:39 PM, Lorenzo Pieralisi wrote:
> This patch is v2 of a previous posting:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186352.html
> 
> v2 changes:
> 
> - removed duplicated idle statistics and irq enabling
> - use MPIDR masks to compute cluster and cpu ids

Hi Lorenzo,

I don't think this patch is still in RFC but ready for merging if nobody
complains :)

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
