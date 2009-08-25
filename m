From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Aug 2009 10:31:52 +0100
Subject: RealView: Fix SD/MMC card detection on RealView PB1176
In-Reply-To: <9e87092b9e1a4e0f9c15ff9dfc150978@dr116.cyberspaceindia.com>
References: <9e87092b9e1a4e0f9c15ff9dfc150978@dr116.cyberspaceindia.com>
Message-ID: <1251192712.15678.32.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-08-25 at 14:45 +0530, Somshekar ChandrashekarKadam wrote:
> I see this patch
> 
>  RealView: Fix SD/MMC card detection on RealView PB1176
[...]
> This is no yet made to Kernel.org nor to stable arm git or is it
> dropped, or will be supported later.

The original patch was accessing the GPIO directly and it was suggested
that it should use the gpiolib support added to the kernel. I didn't
have time to re-implement it (I may do it at some point, though not sure
exactly when).

-- 
Catalin
