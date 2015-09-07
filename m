From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Mon, 7 Sep 2015 23:08:36 +0900
Subject: [RFC PATCH 2/3] arm64: Introduce IRQ stack
In-Reply-To: <20150904171247.GA1786@localhost>
References: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
 <1441376587-12979-3-git-send-email-jungseoklee85@gmail.com>
 <20150904171247.GA1786@localhost>
Message-ID: <F6AD9E22-F3C9-46A7-B668-032553CCD23F@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 5, 2015, at 2:12 AM, Alexnader Kuleshov wrote:

> Hello Jungseok,

Hello Alexnader,

> On 09-04-15, Jungseok Lee wrote:
>> +config IRQ_STACK
>> +	bool "Use separate kernel stack when handling interrupts"
>> +	depends on ARM64_4K_PAGES
>> +	help
>> +	  Say Y here if you want to use separate kernel stack to handle both
>> +	  hard and soft interrupts. As reduceing memory footprint regarding
>> +	  kernel stack, it benefits low memory platforms.
> 
> s/reduceing/reducing

Thanks for pointing out the typo.

I will update the help message in the next version.

Best Regards
Jungseok Lee
