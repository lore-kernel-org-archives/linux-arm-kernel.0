From: oliver@schinagl.nl (Olliver Schinagl)
Date: Mon, 9 May 2016 11:53:16 +0200
Subject: [PATCHv4] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <20160508180941.GC6167@lukather>
References: <1462439332-26215-1-git-send-email-oliver@schinagl.nl>
 <20160508180941.GC6167@lukather>
Message-ID: <57305E0C.8040304@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Maxime,

On 08-05-16 20:09, Maxime Ripard wrote:
> On Thu, May 05, 2016 at 11:08:52AM +0200, Olliver Schinagl wrote:
>> There are 3 kinds of OLinuXino Lime2 boards.
>> One without any on board storage, one with NAND storage and one with
>> eMMC storage. This patch adds the eMMC variant of boards.
>>
>> eMMC storage is different from a regular SD card in that it is soldered
>> on the board and cannot be changed. Additionally, it shares pins with
>> the NAND module and with the second SPI port.
>>
>> Changeslog:
>>
>> v4:
>>    Add board compatibles
>>
>> v3:
>>    Add pwr-seq-emmc with the reset gpio
>>
>> v2:
>>    Remove unsupported no-1.8-v property, add vqmmc property
>>
>> v1:
>>    Initial bare bone version
> This is not something we want in the commit log. This should go below
> the --- so that it's dropped when applied.
Sorry about that, I didn't know the --- trick. ChenYu reminded of it 
however, so that'll go into my toolblox.
>
> Removed and applied.
Thanks for fixing it, much appreciated :)
>
> Thanks,
> Maxime
>
