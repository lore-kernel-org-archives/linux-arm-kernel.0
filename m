From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 2 Mar 2015 17:14:00 +0200
Subject: [RFC PATCH 0/4] make memtest a generic kernel feature
In-Reply-To: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20150302151400.GI15668@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Mon, Mar 02, 2015 at 02:55:41PM +0000, Vladimir Murzin wrote:
> Memtest is a simple feature which fills the memory with a given set of
> patterns and validates memory contents, if bad memory regions is detected it
> reserves them via memblock API. Since memblock API is widely used by other
> architectures this feature can be enabled outside of x86 world.
> 
> This patch set promotes memtest to live under generic mm umbrella and enables
> memtest feature for arm/arm64.

Please update the architectures list in the 'memtest' entry at 
Documentation/kernel-parameters.txt.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
