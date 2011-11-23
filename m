From: amit.kachhap@gmail.com (amit kachhap)
Date: Wed, 23 Nov 2011 14:18:32 +0530
Subject: [PATCH V3 2/6] ARM: s5p: remove useless churn in sleep.S
In-Reply-To: <20111122094821.GU9581@n2100.arm.linux.org.uk>
References: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
 <1321954532-18724-3-git-send-email-amit.kachhap@linaro.org>
 <20111122094821.GU9581@n2100.arm.linux.org.uk>
Message-ID: <CADGdYn4XHr7t6+bcz+iWMZ0pSK8=UUy+GYuQ9gi13LRPqCdjNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 3:18 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 22, 2011 at 03:05:28PM +0530, Amit Daniel Kachhap wrote:
>> This patch cleans up sleep code in preparation for L2 resume code
>> and hotplug functions
>
> I wonder whether anyone read the comments in this file before they
> changed the section for the code.
> ? ? ? ?/*
> ? ? ? ? * sleep magic, to allow the bootloader to check for an valid
> ? ? ? ? * image to resume to. Must be the first word before the
> ? ? ? ? * s3c_cpu_resume entry.
> ? ? ? ? */

Ok,This looks like an error. Thanks for pointing this out. Will put
the entire section into data.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
