From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Mar 2012 15:58:39 -0700
Subject: [PATCH] ARM: S3C24XX: fix missing common.h in mach-s3c24xx/
In-Reply-To: <4F74556F.10704@mvista.com>
References: <1332980074-4614-1-git-send-email-kgene.kim@samsung.com>
 <4F74556F.10704@mvista.com>
Message-ID: <4F763A9F.2010907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> Hello.
>
> On 29-03-2012 4:14, Kukjin Kim wrote:
>

[...]

>> +#ifdef CONFIG_CPU_S3C2410
>> +void s3c2410_restart(char mode, const char *cmd);
>> +#endif
>> +
>> +#ifdef CONFIG_CPU_S3C244X
>> +void s3c244x_restart(char mode, const char *cmd);
>> +#endif
>
> Those #ifdef's around function prototypes are not necessary.
>
OK, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
