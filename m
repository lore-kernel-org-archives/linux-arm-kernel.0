From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 27 Nov 2013 09:55:47 -0800
Subject: [PATCH v2] use -fstack-protector-strong
In-Reply-To: <20131127175442.GA28088@gmail.com>
References: <20131126203727.GA352@www.outflux.net>
 <20131127112731.GA10435@gmail.com>
 <CAGXu5jLY+AzaB4f92OLA6Orm=Mr9C+G+-mgOmSf-yju+YCmaUg@mail.gmail.com>
 <20131127175442.GA28088@gmail.com>
Message-ID: <52963223.9080701@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2013 09:54 AM, Ingo Molnar wrote:
>>
>> Looks to be 2% for defconfig. That's way better. Shall I send a v3?
> 
> Well, it's better than 9%, but still almost an order of magnitude 
> higher than the cost is today, and a lot of distros have 
> CONFIG_CC_STACKPROTECTOR=y.
> 
> So it would be nice to measure how much the instruction count goes up 
> in some realistic system-bound test. How much does something like 
> kernel/built-in.o increase, as per 'size' output?
> 

Do we need CONFIG_CC_STACKPROTECTOR_STRONG?

	-hpa
