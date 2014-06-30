From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Jun 2014 12:30:50 +0200
Subject: [PATCH 07/16] ARM: mvebu: Make the CPU idle initialization more
 generic
In-Reply-To: <20140628145625.GL23978@titan.lakedaemon.net>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-8-git-send-email-gregory.clement@free-electrons.com>
 <53AD7C90.6080600@free-electrons.com>
 <20140628145625.GL23978@titan.lakedaemon.net>
Message-ID: <53B13C5A.80603@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,


>>> +	np = of_find_matching_node_and_match(NULL, of_cpuidle_table,
>>> +					&match);
>>> +
>>
>> The following part was missing (without this the kernel hang on Armada 375)
>>
>> +       if (!np)
>> +               return 0;
> 
> If there's no other changes, I can fix this up when I apply it.  As well
> as the S-o-b.


Thanks. Let's hope it will be the case, and there will no need to a
new version of this series. :)

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
