From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 6 Sep 2012 19:25:51 -0300
Subject: [PATCH 01/11] ARM: defconfig: Remove CONFIG_MISC_DEVICES
In-Reply-To: <201208181808.21484.arnd@arndb.de>
References: <1345307035-3545-1-git-send-email-festevam@gmail.com>
 <201208181808.21484.arnd@arndb.de>
Message-ID: <CAOMZO5C2ihKUeQk17JOHc9VXAB3KTeQLS3OcLOiiUC8jucsexg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sat, Aug 18, 2012 at 3:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 18 August 2012, Fabio Estevam wrote:
>>
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> commit 7c5763 (drivers:misc: Remove MISC_DEVICES config option) removed
>> CONFIG_MISC_DEVICES option, so remove the occurrences from the config files
>> as well.
>>
>> Cc: <linux-arm-kernel@lists.infradead.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I am not sure who would pick up this series.

Is it possible for you to apply these patches?

Thanks,

Fabio Estevam
