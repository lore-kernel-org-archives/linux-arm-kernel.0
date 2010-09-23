From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 23 Sep 2010 14:08:05 +0800
Subject: PXA270 audio problem
In-Reply-To: <AANLkTi=_AANevVpthOKuRfkkvU9mKMWsmpHc+XohoUwg@mail.gmail.com>
References: <AANLkTi=_AANevVpthOKuRfkkvU9mKMWsmpHc+XohoUwg@mail.gmail.com>
Message-ID: <AANLkTimOM7EnMgfDVqZ-Oq_cLOUwR-GeKEwDD9HsLqQa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 1:33 PM, Santhosh N <san.mlists@gmail.com> wrote:
> Dear All,
>
> I am running linux 2.6.26 kernel on a PXA270 board. A UCB1400 chip
> used for audio and touchscreen in that. I have been facing a problem
> with audio.
>
> The audio plays properly, but suddenly stops. I get the following message:
> ALSA sound/core/pcm_native.c:1513: playback drain error (DMA or IRQ trouble?)
>
> I have noticed that the DMA interrupts stop coming. Where as the AC97
> interrupts come properly.
>
> Any help in solving this will be grateful.
>

Dumping the DMA registers and the AC97 controller registers would
be helpful.

> Regards,
> Santhosh N
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
