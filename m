From: sugar.zhang@rock-chips.com (sugar)
Date: Thu, 8 Oct 2015 09:47:37 +0800
Subject: [alsa-devel] [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels
 capture and lrck-mode support
In-Reply-To: <F2F204F7-F5A8-4152-BF1D-454EB3E35F34@crome.org>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk> <5608F74C.3000104@rock-chips.com>
 <20150930184655.GX15635@sirena.org.uk> <5614D162.3020500@rock-chips.com>
 <F2F204F7-F5A8-4152-BF1D-454EB3E35F34@crome.org>
Message-ID: <5615CB39.1060208@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caleb,

we haven't support 16 channels capture and playback yet, would you mind 
to detail the use case? if must, we may support this feature on next 
generation chip.

? 10/7/2015 21:04, Caleb Crome ??:
> Hi sugar,
>     Can the rockchip support more than 8 channels?  Ideally, we would like to capture 16 channels and playback 16 channels simultaneously.
>
> Thanks,  Caleb
>
> Sent from my iPhone
