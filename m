From: ayaka@soulik.info (ayaka)
Date: Thu, 18 Aug 2016 22:20:27 +0800
Subject: [PATCH 1/2] ARM: dts: rockchip: remove excess sd properties for
 firefly reload
In-Reply-To: <49067977.DDSr6TXKjU@diego>
References: <19126716.OZv44ZHtAK@diego>
 <1471453391-10267-1-git-send-email-ayaka@soulik.info>
 <1471453391-10267-2-git-send-email-ayaka@soulik.info>
 <49067977.DDSr6TXKjU@diego>
Message-ID: <e28a9479-acbe-80f9-0985-d8f084b55245@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/18/2016 09:35 PM, Heiko St?bner wrote:
> Am Donnerstag, 18. August 2016, 01:03:10 schrieb Randy Li:
>> Because of a bug in hardware design, the sdcard at firefly
>> rk3288 reload board can't switch the io voltage level to 1.8v.
>>
>> Signed-off-by: Randy Li <ayaka@soulik.info>
> applied to my dts32 branch for 4.9
>
> In the future, please try to base your patches either on the correct dts
> branch in my repo [0] or simply on linux-next which does contain these too,
OK, I would based on linux-next time.
> as I did reorder some things when applying your initial firefly-reload patch.
Thank you for guide
>
> Thanks
> Heiko
>
>
> [0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/
> [dts patches v4.x-armsoc/dts32 and v.x-armsoc/dts64 depending on what board
> you're working on]
