From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 30 Jan 2014 11:36:43 +0000
Subject: [PATCH 2/9] ARM64: get rid of arch_cpu_idle_prepare()
In-Reply-To: <alpine.LFD.2.11.1401291249240.1652@knanqh.ubzr>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
 <20140127154315.GG32608@arm.com>
 <alpine.LFD.2.11.1401271047240.1652@knanqh.ubzr>
 <20140127155755.GH32608@arm.com>
 <alpine.LFD.2.11.1401291249240.1652@knanqh.ubzr>
Message-ID: <20140130113643.GK30161@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 06:00:45PM +0000, Nicolas Pitre wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> Subject: [PATCH] ARM64: FIQs are unused
> 
> So any FIQ handling is superfluous at the moment.  The functions to 
> disable/enable FIQs is kept around if ever someone needs them in the 
> future, but existing calling sites including arch_cpu_idle_prepare() 
> may go for now.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Thanks. Applied.

-- 
Catalin
