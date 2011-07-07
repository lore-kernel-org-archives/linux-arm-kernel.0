From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 7 Jul 2011 15:49:21 +0100
Subject: [PATCHv2] remove unnecessary cache flush on v6 copypage
In-Reply-To: <20110707143019.GA16819@heechul-desktop>
References: <20110707143019.GA16819@heechul-desktop>
Message-ID: <20110707144921.GA15429@1n450.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 09:30:19AM -0500, Heechul Yun wrote:
> ARM: mm: remove unnecessary cache flush on v6 copypage

Just move this line in the subject and remove it from the body.

> Originally introduced to maintain coherency between icache and dcache
> in v6 nonaliasing mode. This is now handled by __sync_icache_dcache since
> c0177800, therefore unneceary in this function.  

Minor typo - "unnecessary".

Thanks.

-- 
Catalin
