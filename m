From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 11:15:02 -0500
Subject: [PATCH 2/3] ARM: use asm-generic version of kmap_types.h
In-Reply-To: <201207160918.33856.arnd@arndb.de>
References: <1342410836-6010-1-git-send-email-robherring2@gmail.com>
 <1342410836-6010-3-git-send-email-robherring2@gmail.com>
 <201207160918.33856.arnd@arndb.de>
Message-ID: <50043E06.30408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2012 04:18 AM, Arnd Bergmann wrote:
> On Monday 16 July 2012, Rob Herring wrote:
>>
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> kmap_types.h is virtually unused now with the stack based kmap_atomic,
>> so we can just use the generic one. This does bump KM_TYPE_NR from 16
>> to 20, but there is still plenty of space left in the fixmap area.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
> 
> I would suggest you drop this one. There is a series for removing
> kmap_types.h on all architectures already, so let's avoid the conflict.

Agreed. I was wondering why that hadn't happened...

Rob
