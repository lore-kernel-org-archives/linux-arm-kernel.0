From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 15:55:13 +0300
Subject: [PATCH 0/2] ARM: DTS: am437x-sk-evm: Use simple-card for audio
 support
In-Reply-To: <20150702121045.GC5837@saruman.tx.rr.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
 <20150702121045.GC5837@saruman.tx.rr.com>
Message-ID: <559534B1.5090301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2015 03:10 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jul 02, 2015 at 02:58:04PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> There is no reason to use the davinci-evm machine driver's compatible for audio
>> support since the setup is simple and the common simple-audio-card can handle it
>> just fine.
>> Also add McASP1 sleep pin configuration.
>>
>> Regards,
>> Peter
>> ---
>> Peter Ujfalusi (2):
>>   ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
>>   ARM: DTS: am437x-sk-evm: Switch using simple-audio-card for audio
>>     support
> 
> you should add a patch enabling CONFIG_SND_SIMPLE_CARD=m in
> omap2plus_defconfig

Oh, true.
I'll then resend this as part of a bigger series (am335x-evmsk/evm,
am437x-gp/epos/sk).
I planned to send them as separate, but you are right, simple card need to be
enabled first.

-- 
P?ter
