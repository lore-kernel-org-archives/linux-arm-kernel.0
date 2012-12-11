From: bard.shen@gmail.com (Bo Shen)
Date: Tue, 11 Dec 2012 17:55:42 +0800
Subject: need help in porting wm8731 codec on SAMSUNG S3C2416
In-Reply-To: <CALM_QrWRk9FCS6t3Gs=7qF8fWHM9zoKFY_K67LAGjGHa5CZ9cw@mail.gmail.com>
References: <CALM_QrWRk9FCS6t3Gs=7qF8fWHM9zoKFY_K67LAGjGHa5CZ9cw@mail.gmail.com>
Message-ID: <50C7031E.2020107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ratheendran R,

On 12/11/2012 14:44, Ratheendran R wrote:
> Dear All,
>
> We are using kit2416 board based samsung s3c2416 SOC using linux kernel
> 2.6.21, wm8731 codec is used with the soc on i2s bus.
>
> I am trying porting linux3.6.8 on the same board,now porting older soc
> audio driver for codec onto the newer kernel.
>
> I am getting the below kernel messages, snapshot on audio driver
> registration.
>
> /soc-audio soc-audio: ASoC machine SMDK2416wm8731 should use
> snd_soc_register_card()
> soc-audio soc-audio: CODEC wm8731 not registered

For your reference, my codec name is: ".codec_name = "wm8731.0-001b","
Please check it in your system. The path is /sys/devices/...

Best Regards,
Bo Shen
