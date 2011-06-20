From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 19 Jun 2011 23:13:46 -0400 (EDT)
Subject: [RFC PATCH v2 1/5] ARM: mm: Add generic proc/arch struct
	definition macros
In-Reply-To: <20110616100328.GA2460@arm.com>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
	<1308049105-16080-2-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1106151944240.2142@xanadu.home>
	<20110616100328.GA2460@arm.com>
Message-ID: <alpine.LFD.2.00.1106192311080.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jun 2011, Dave Martin wrote:

> Alternatively, we could propose a change <linux/init.h> to split the
> __INITDATA macro up, and define the related macros in a sane way:
> 
> #define __INITDATA_NAME .init.data
> #define __INITDATA_FLAGS "aw",%progbtis
> #define __initdata __section(__INITDATA_NAME)
> #define __INITDATA .section __stringify(__INITDATA_NAME),__INITDATA_FLAGS
> 
> Any thoughts on that?

I do like it.


Nicolas
