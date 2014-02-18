From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Feb 2014 16:40:24 +0000
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <5302B306.8090503@samsung.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <52F99056.6010906@samsung.com>
 <CAOesGMgdDnSc=Y8i6JYeGewCh1RPYZ_AxocxKzSD265fa2-yrA@mail.gmail.com>
 <201402141806.12711.arnd@arndb.de> <5302B306.8090503@samsung.com>
Message-ID: <20140218164022.GA12381@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 01:10:30AM +0000, Kukjin Kim wrote:
> As I commented above, how about MCT? Samsung has a plan to use MCT on 
> ARMv8, it is not for used for GH7 though...

Any reason for not using the generic timer?

-- 
Catalin
