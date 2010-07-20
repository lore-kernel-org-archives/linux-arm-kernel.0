From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Jul 2010 15:35:14 +0300
Subject: [PATCH v5 0/4] s3c24xx: iPAQ rx1950 series
In-Reply-To: <1279364224-24525-1-git-send-email-anarsoul@gmail.com>
References: <1279364224-24525-1-git-send-email-anarsoul@gmail.com>
Message-ID: <201007201535.26600.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 17 ???? 2010 13:57:00 ????? Vasily Khoruzhick ???????:
> This patch series adds more support for iPAQ rx1950 PDA to linux:
> 1. LEDs driver -- it controls blue, green and red LEDs on rx1950
> 2. Battery driver -- adds ability to monitor and charge battery.
> This driver is suitable for H1940 PDA aswell (just need to write
> some machine specific callbacks and get voltage LUTs)
> 
> v2: removed ac registration from s3c_adc_battery driver, use
> pda_power instead for ac support
> 
> v3: split LEDs patch to driver and machine parts,
> split battery patch into battery + LED trigger parts,
> now battery driver can skip gpio/callbacks usage
> (if there's no gpio pin to determine that battery is
> full or if charger is enabled automatically)
> 
> v4: add .blink_set callback to LEDs driver instead of
> using LED_HALF value for blinking, remove LED triggers
> from battery driver completely (for now)
> 
> v5: restore lut_acin usage in s3c_adc_battery driver,
> it was accidently removed during removing AC support
> from driver

Ping :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100720/137d6a02/attachment.sig>
