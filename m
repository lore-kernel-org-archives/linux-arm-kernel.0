From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 14 Jun 2010 12:18:24 +0200
Subject: [PATCH v2] rtc-s3c: Fix rtc-s3c driver initialization
In-Reply-To: <201006140904.17950.anarsoul@gmail.com>
References: <1274975846-14006-1-git-send-email-anarsoul@gmail.com>
	<201006140904.17950.anarsoul@gmail.com>
Message-ID: <4C1601F0.1060209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 14-06-10 08:04, Vasily Khoruzhick schreef:
> ? ????????? ?? 27 ??? 2010 18:57:26 ????? Vasily Khoruzhick ???????:
>> setfreq should be called only after rtc device registration,
>> as it uses rtc device; s3c_rtc_cpu_type should be checked
>> only once it was set.
>>
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Hi, Ben.
> 
> What about this patch? I've seen similar series on linux-samsung-soc maillist, 
> but neither their series nor my patch is applied to your tree. Why? :)
> 
> Regards
> Vasily

A similar patch is already in Linus' tree, see e893de59a4982791368b3ce412bc67dd601a88a0.
