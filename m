From: info@lategoodbye.de (Stefan Wahren)
Date: Thu, 19 Nov 2015 17:31:01 +0100
Subject: [PATCH V3 RFT] ARM: bcm2835: enable all bcm2835-relevant in
 defconfig
In-Reply-To: <1445969338-23977-1-git-send-email-stefan.wahren@i2se.com>
References: <1445969338-23977-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <564DF945.6060205@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.10.2015 um 19:08 schrieb Stefan Wahren:
> Rebuild bcm2835_defconfig using "make bcm2835_defconfig;
> make savedefconfig", and enable manually the following features:
>
> * all bcm2835-relevant drivers (MBOX, WDT, DMA, PWM, SND)
> * enable regular stackprotector because CONFIG_CC_STACKPROTECTOR
>    disappear
> * enable some new dependencies in order to keep LED heartbeat
>    ( CONFIG_NEW_LEDS, CONFIG_LEDS_CLASS, CONFIG_LEDS_TRIGGERS )
>
> The following options were removed, because they are enabled implicit:
>
> CONFIG_RD_BZIP2, CONFIG_RD_LZMA, CONFIG_RD_XZ, CONFIG_RD_LZO,
> CONFIG_USB_DWC2_HOST, CONFIG_EXT4_FS, CONFIG_EXT4_FS_POSIX_ACL
>
> These options became obsolete:
>
> CONFIG_RESOURCE_COUNTERS, CONFIG_SCSI_MULTI_LUN
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Any objections about this?

Regards
Stefan
