From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 23 Jul 2013 02:54:06 -0700
Subject: [PATCH, re-send] Always trap on BUG()
In-Reply-To: <20130723093628.GC19786@gmail.com>
References: <201307051738.35930.arnd@arndb.de>
 <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org>
 <20130715222755.GY24642@n2100.arm.linux.org.uk> <51E47924.9030005@zytor.com>
 <20130723093628.GC19786@gmail.com>
Message-ID: <51EE52BE.5080204@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 02:36 AM, Ingo Molnar wrote:
>>
>> Well, there are three alternatives here, right:
>>
>> 1. We can use unreachable(), which means that the compiler can assume it
>> never happens.
> 
> AFAICS this is dangerous as it loses warnings and moves execution into 
> la-la-land without any obvious sign at the C level.
> 

Extremely dangerous.

	-hpa
