From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 23 Jun 2018 11:48:51 -0700
Subject: [GIT PULL 1/3] Broadcom devicetree fixes for 4.18
In-Reply-To: <CAOesGMjVK8tjndxdEWM1cCLb4ev7ur7Q-eDM8NM=S9pKAkRm4A@mail.gmail.com>
References: <20180619233104.32173-1-f.fainelli@gmail.com>
 <CAOesGMjVK8tjndxdEWM1cCLb4ev7ur7Q-eDM8NM=S9pKAkRm4A@mail.gmail.com>
Message-ID: <80DE264C-E5B2-4C9D-AC3A-CD5BAF021E2A@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On June 23, 2018 10:20:03 AM PDT, Olof Johansson <olof@lixom.net> wrote:
>On Tue, Jun 19, 2018 at 4:31 PM, Florian Fainelli
><f.fainelli@gmail.com> wrote:
>> The following changes since commit
>ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>
>>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>
>> are available in the git repository at:
>>
>>   https://github.com/Broadcom/stblinux.git
>tags/arm-soc/for-4.18/devicetree-fixes
>>
>> for you to fetch changes up to
>6cb1628ad3506b315cdddd7676db0ff2af378d28:
>>
>>   ARM: dts: Cygnus: Fix PCIe controller interrupt type (2018-06-18
>09:40:36 -0700)
>>
>> ----------------------------------------------------------------
>> This pull request contains Broadcom ARM-based SoCs Device Tree fixes
>for
>> 4.18, please pull the following:
>>
>> - Ray fixes the I2C and PCIe interrupt types for the Cygnus SoC
>>
>> - Florian fixes the I2C and PCIe interrupts for the Northstar
>>   (BCM5301x), Northstar Plus and Hurricane 2 SoCs
>
>Merged, thanks. What's the problem seen, btw? Just for correctness
>sake or did it cause actual problems?

This is not causing any functional problem yet, but Marc Z. introduced a loud check in the GIC driver that will help correct incorrectly specified interrupt specifiers.

-- 
Florian
