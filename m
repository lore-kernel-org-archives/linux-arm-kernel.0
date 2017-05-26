From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 26 May 2017 13:14:49 +0530
Subject: [PATCH] ARM: dts: keystone-k2l: fix broken Ethernet due to
 disabled OSR
In-Reply-To: <CAK8P3a2yYK3zO=K__W4jCFYYpFCZLYkm97ADZHunttdUmO_ZOw@mail.gmail.com>
References: <59ba5ef37f17ff1c10d9d52ca06ef341b2d476eb.1490782833.git.nsekhar@ti.com>
 <5adb4f5d-78c4-453d-898d-60c588eb1d14@oracle.com>
 <CAK8P3a2yYK3zO=K__W4jCFYYpFCZLYkm97ADZHunttdUmO_ZOw@mail.gmail.com>
Message-ID: <1a5730ea-7601-d0bb-15ef-168252f54446@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Friday 31 March 2017 03:43 PM, Arnd Bergmann wrote:
> On Wed, Mar 29, 2017 at 6:13 PM, santosh.shilimkar at oracle.com
> <santosh.shilimkar@oracle.com> wrote:
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> Acked-by: Tero Kristo <t-kristo@ti.com>
>>> [nsekhar at ti.com: commit message updates, port to latest mainline]
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>> ---
>>
>> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
>>
>> Can you please pick this up for rcx fixes ?
> 
> Applied, thanks!

Looks like this fix never made to to mainline. Do you have the patch
with you still? It will have to be marked for v4.11 stable and pushed.

Thanks,
Sekhar
