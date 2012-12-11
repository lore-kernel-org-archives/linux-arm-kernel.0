From: ratheendran.s@gmail.com (Ratheendran R)
Date: Tue, 11 Dec 2012 12:14:58 +0530
Subject: need help in porting wm8731 codec on SAMSUNG S3C2416
Message-ID: <CALM_QrWRk9FCS6t3Gs=7qF8fWHM9zoKFY_K67LAGjGHa5CZ9cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

We are using kit2416 board based samsung s3c2416 SOC using linux kernel
2.6.21, wm8731 codec is used with the soc on i2s bus.

I am trying porting linux3.6.8 on the same board,now porting older soc
audio driver for codec onto the newer kernel.

I am getting the below kernel messages, snapshot on audio driver
registration.

*soc-audio soc-audio: ASoC machine SMDK2416wm8731 should use
snd_soc_register_card()
soc-audio soc-audio: CODEC wm8731 not registered
soc-audio soc-audio: Failed to register card
platform soc-audio: Driver soc-audio requests probe deferral
TCP: cubic registered
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
ALSA device list:
  No soundcards found.

*
I have attached the modified driver for reference.

kindly give your valuable suggestions.

Thanks,
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121211/3d5da970/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smdk2416_wm8731.c
Type: text/x-csrc
Size: 5459 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121211/3d5da970/attachment.bin>
