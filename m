From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 14 Jan 2017 19:01:16 -0800
Subject: [PATCH v6 0/4] ARM: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20170104223955.22859-1-f.fainelli@gmail.com>
References: <20170104011417.1496-1-f.fainelli@gmail.com>
 <20170104223955.22859-1-f.fainelli@gmail.com>
Message-ID: <f7ff1040-20da-4ccf-411a-a665f07286c0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 01/04/17 ? 14:39, Florian Fainelli a ?crit :
> This patch series builds on top of Laura's [PATCHv6 00/10] CONFIG_DEBUG_VIRTUAL
> for arm64 to add support for CONFIG_DEBUG_VIRTUAL for ARM.
> 
> This was tested on a Brahma B15 platform (ARMv7 + HIGHMEM + LPAE).
> 
> Note that the treewide changes would involve a huge CC list, which
> is why it has been purposely trimmed to just focusing on the DEBUG_VIRTUAL
> aspect.
> 
> Catalin, provided that you take Laura's series, I suppose I would submit
> this one through Russell's patch system if that's okay with everyone?

Submitted through Russell's patch tracking system as #8638-8641
-- 
Florian
