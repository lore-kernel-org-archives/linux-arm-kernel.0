From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Sat, 10 Nov 2018 13:38:43 +0100
Subject: [PATCH v2 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
In-Reply-To: <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
 <03f41ca8-68c6-f075-cb1e-c7f630a3b128@free.fr>
 <20181108093617.GB8433@e107155-lin>
 <CAK8P3a1129B-u60sjHCvLuE8i6OCJRDSe-JFy3S-JJWFGbHCPQ@mail.gmail.com>
Message-ID: <3f5ff18e-a264-981d-505f-69636fcf4355@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2018 09:57, Arnd Bergmann wrote:

> On Thu, Nov 8, 2018 at 10:36 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On Wed, Nov 07, 2018 at 11:39:42PM +0100, Marc Gonzalez wrote:
>>> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
>>> dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64.
>>>
>>
>> Looks good,
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> But I left it intentionally to avoid churn assuming it will go away when
>> ARM SoC team runs savedefconfig and sync the defconfig.
> 
> I would never do that,

Isn't that what commit c432c0880596 did? :-p

$ git show --stat c432c0880596 
 arch/arm64/configs/defconfig | 102 +++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------
 1 file changed, 39 insertions(+), 63 deletions(-)
