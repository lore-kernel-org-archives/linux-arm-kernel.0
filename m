From: caleb@crome.org (Caleb Crome)
Date: Wed, 7 Oct 2015 19:36:23 -0700
Subject: [alsa-devel] [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels
 capture and lrck-mode support
In-Reply-To: <5615CB39.1060208@rock-chips.com>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk> <5608F74C.3000104@rock-chips.com>
 <20150930184655.GX15635@sirena.org.uk> <5614D162.3020500@rock-chips.com>
 <F2F204F7-F5A8-4152-BF1D-454EB3E35F34@crome.org>
 <5615CB39.1060208@rock-chips.com>
Message-ID: <35DAC0DA-9141-4D6B-A065-4D0FE340E5D0@crome.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We make microphone arrays with lots of microphones.  Some as few as 2, many with 7 channels, and a few with 14 or more.  

Can you support 8 channels with 32 bits/sample?  That would work, we can just set the codecs for 16-bit samples, which would be 256 bits/frame.

Hope you had a great golden week holiday!

Thanks,  
    Caleb Crome




Sent from my iPhone

> On Oct 7, 2015, at 6:47 PM, sugar <sugar.zhang@rock-chips.com> wrote:
> 
> Hi Caleb,
> 
> we haven't support 16 channels capture and playback yet, would you mind to detail the use case? if must, we may support this feature on next generation chip.
> 
>> ? 10/7/2015 21:04, Caleb Crome ??:
>> Hi sugar,
>>    Can the rockchip support more than 8 channels?  Ideally, we would like to capture 16 channels and playback 16 channels simultaneously.
>> 
>> Thanks,  Caleb
>> 
>> Sent from my iPhone
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
