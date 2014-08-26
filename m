From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 26 Aug 2014 17:22:08 +0530
Subject: [PATCH v2 0/6] ARM: DT/davinci: Audio for da850-evm in DT boot
In-Reply-To: <53FC6069.7000105@ti.com>
References: <1406873610-5037-1-git-send-email-peter.ujfalusi@ti.com>
 <53FC6069.7000105@ti.com>
Message-ID: <53FC74E8.80206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 August 2014 03:54 PM, Sekhar Nori wrote:
> On Friday 01 August 2014 11:43 AM, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v1:
>> - fixed the address missmatch for tlv320aic3106 codec (@1b -> 18)
>> - The edma patches has been taken by Vinod, they should be in linux-next soon.
> 
> I assume all of these 6 patches are meant to go through ARM SoC. I have
> applied all of them for v3.18.
> 
>> The following series will enable audio via simple card on the board when booted
>> with DT.
> 
> Thanks for doing this.

Also tested audio playback and record on DA850 EVM. Works great!

Thanks,
Sekhar
