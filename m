From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Wed, 18 May 2011 08:33:57 -0400
Subject: [PATCH 9/9] davinci: da850: changed SRAM allocator to shared ram.
In-Reply-To: <4DD39F8B.3060209@mvista.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024CF13ED4@dbde02.ent.ti.com>
	<cover.1305668470.git.bengardiner@nanometrics.ca>
	<e6e7b13ce98f0216bbd714fb6a4f11effcbc721d.1305668470.git.bengardiner@nanometrics.ca>
	<4DD39F8B.3060209@mvista.com>
Message-ID: <BANLkTi=29RYRADz+DhFpAcJEL5q3L-FvXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thank you for the reviews.

On Wed, May 18, 2011 at 6:29 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:

[...]

>> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h
>> b/arch/arm/mach-davinci/include/mach/da8xx.h
>> index e4fc1af..09b8ddb 100644
>> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
>> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
>> @@ -72,6 +72,7 @@ extern unsigned int da850_max_speed;
>> ?#define DA8XX_AEMIF_CTL_BASE ?0x68000000
>> ?#define DA8XX_DDR2_CTL_BASE ? 0xb0000000
>> ?#define DA8XX_ARM_RAM_BASE ? ?0xffff0000
>> +#define DA8XX_SHARED_RAM_BASE ?0x80000000
>
> ? Please keep this list sorted.

Will do so in V2. I am currently imagining that the v2 series will be
based on Russell's next SRAM consolidation patch based on
Jean-Christophe's genpool patch.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
