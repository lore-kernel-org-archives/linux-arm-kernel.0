From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Sep 2009 09:56:30 +0100
Subject: ARM Cortex-based multi-core support?
In-Reply-To: <008d01ca3128$0b012e00$21038a00$%yang@samsung.com>
References: <008d01ca3128$0b012e00$21038a00$%yang@samsung.com>
Message-ID: <1252486591.24414.1.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-09-09 at 17:32 +0900, Jinsung Yang wrote:
> I'm researching that the latest kernel can support ARM cortex based
> multi-core platform..
> First, just I need to know current status.. someone knows?

AFAICT, it's all supported and works fine (with a few minor issues like
the recent thread on non position-independent dynamic shared objects, if
your toolchain generates such things).

-- 
Catalin
