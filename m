From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Jul 2014 00:57:54 +0200
Subject: [PATCH 01/16] ARM: mvebu: Sort the headers of pmsu.c in alphabetic
 order
In-Reply-To: <20140630141630.684479f6@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-2-git-send-email-gregory.clement@free-electrons.com>
 <20140630141630.684479f6@free-electrons.com>
Message-ID: <53B48E72.3050907@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,


>>  #include <linux/cpu_pm.h>
>> -#include <linux/kernel.h>
>>  #include <linux/init.h>
>> -#include <linux/of_address.h>
>> +#include <linux/kernel.h>
>>  #include <linux/io.h>
> 
> So, with your patch applied, if I'm correct, we will have:
> 
> #include <linux/init.h>
> #include <linux/kernel.h>
> #include <linux/io.h>
> 
> It seems like we're not yet alphabetically sorted here :)

Indeed, I will fix it


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
