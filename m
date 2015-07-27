From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 27 Jul 2015 20:53:09 +0300
Subject: [PATCH v4 7/7] x86/kasan: switch to generic
 kasan_populate_zero_shadow()
In-Reply-To: <20150727165749.GD350@e104818-lin.cambridge.arm.com>
References: <1437756119-12817-1-git-send-email-a.ryabinin@samsung.com>
 <1437756119-12817-8-git-send-email-a.ryabinin@samsung.com>
 <20150727165749.GD350@e104818-lin.cambridge.arm.com>
Message-ID: <55B67005.9030802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2015 07:57 PM, Catalin Marinas wrote:
> On Fri, Jul 24, 2015 at 07:41:59PM +0300, Andrey Ryabinin wrote:
>> Now when we have generic kasan_populate_zero_shadow() we could
>> use it for x86.
>>
>> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> In the interest of facilitating the upstreaming of these patches (when
> ready ;), can you merge this patch with 2/7? The second patch is already
> touching x86, so just call it something like "x86/kasan: Generalise
> kasan shadow mapping initialisation".
> 

Ok
