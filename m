From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 03 Mar 2015 09:28:39 +0000
Subject: [RFC PATCH 0/4] make memtest a generic kernel feature
In-Reply-To: <20150302151400.GI15668@tarshish>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
 <20150302151400.GI15668@tarshish>
Message-ID: <54F57EC7.1060202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/15 15:14, Baruch Siach wrote:
> Hi Vladimir,
> 
> On Mon, Mar 02, 2015 at 02:55:41PM +0000, Vladimir Murzin wrote:
>> Memtest is a simple feature which fills the memory with a given set of
>> patterns and validates memory contents, if bad memory regions is detected it
>> reserves them via memblock API. Since memblock API is widely used by other
>> architectures this feature can be enabled outside of x86 world.
>>
>> This patch set promotes memtest to live under generic mm umbrella and enables
>> memtest feature for arm/arm64.
> 
> Please update the architectures list in the 'memtest' entry at 
> Documentation/kernel-parameters.txt.

Thanks for pointing at it. I'll add updates for documentation to my next
version.

Vladimir

> 
> baruch
> 
