From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 23 Jun 2018 11:49:29 -0700
Subject: [GIT PULL 2/3] Broadcom devicetree-arm64 fixes for 4.18
In-Reply-To: <CAOesGMgvtqbKJpgj6_emT0MoPBFW5JRQOL2b57JknYMGV320Sw@mail.gmail.com>
References: <20180619233104.32173-1-f.fainelli@gmail.com>
 <20180619233104.32173-2-f.fainelli@gmail.com>
 <CAOesGMgvtqbKJpgj6_emT0MoPBFW5JRQOL2b57JknYMGV320Sw@mail.gmail.com>
Message-ID: <651633D4-95E3-4E7C-88DA-3B0B485C3F39@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On June 23, 2018 10:21:02 AM PDT, Olof Johansson <olof@lixom.net> wrote:
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
>tags/arm-soc/for-4.18/devicetree-arm64-fixes
>>
>> for you to fetch changes up to
>75af23c4736c5633894ea0baf9bca1cf6b248ca4:
>>
>>   arm64: dts: Stingray: Fix I2C controller interrupt type (2018-06-18
>09:47:36 -0700)
>>
>> ----------------------------------------------------------------
>> This pull request contains Broadcom ARM64-based SoCs Device Tree
>fixes
>> for 4.18, please pull the following:
>>
>> - Scott fixes both the bcm958742k and bcm958742t reference boards to
>>   have the correct eMMC voltage specified
>>
>> - Ray fixes the I2C and PCIe Device Tree nodes interrupt specifiers
>for
>>   Northstar 2 and Stingray SoCs.
>>
>> ----------------------------------------------------------------
>> Ray Jui (3):
>>       arm64: dts: ns2: Fix I2C controller interrupt type
>>       arm64: dts: ns2: Fix PCIe controller interrupt type
>>       arm64: dts: Stingray: Fix I2C controller interrupt type
>>
>> Scott Branden (2):
>>       arm64: dts: specify 1.8V EMMC capabilities for bcm958742k
>>       arm64: dts: specify 1.8V EMMC capabilities for bcm958742t
>
>Merged, thanks!
>
>Btw, for fixes you don't need to split up per topic, we're happy to
>take single branches there since volume tends to be lower and we pile
>it all into a fixes branch at our end anyway.

Good to know that will simplify things greatly on my side. Thanks!

-- 
Florian
