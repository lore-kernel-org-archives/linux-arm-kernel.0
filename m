From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 28 Mar 2014 16:29:51 +0530
Subject: [PATCH 1/2] ARM: OMAP2+: L2 cache: use macro instead of const
 number
In-Reply-To: <20140328104954.GC27282@n2100.arm.linux.org.uk>
References: <5ea7277c21215c7b4aa776d5379dc2d6263228c6.1395994759.git.nsekhar@ti.com>
 <20140328104954.GC27282@n2100.arm.linux.org.uk>
Message-ID: <53355627.5010609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Friday 28 March 2014 04:19 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 28, 2014 at 02:05:28PM +0530, Sekhar Nori wrote:
>> From: Afzal Mohammed <afzal@ti.com>
>>
>> Its better to use the available macro than 0x1.
>> No functional change.
>>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>> This series applies to latest of linux-next/master
> 
> NAK.  See my L2 cache series posted on LAKML which completely removes
> this code.

Okay. Will look at your series now.

Thanks,
Sekhar
