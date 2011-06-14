From: andreiw@motorola.com (Andrei Warkentin)
Date: Mon, 13 Jun 2011 19:09:06 -0500
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <201106030956.43174.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de>
	<BANLkTi=xVzdLDq5wbzLtQFu+nz=8G9SbKQ@mail.gmail.com>
	<201106030956.43174.heiko@sntech.de>
Message-ID: <BANLkTi=YvSL_yzku6v3tsJaaLTL=fBXShg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Everybody,

On Fri, Jun 3, 2011 at 2:56 AM, Heiko St?bner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Freitag 03 Juni 2011, 01:48:05 schrieb Kyungmin Park:
> > As I don't have the s3c2416 user manaul, I'm not sure it's support
> > AUTO CMD12 or not. but at least it's support at s3c6410 and later.
> According to the manual, the 2416 supports AUTO CMD12.
>
> As I wrote disabling auto cmd12 only works sometimes and other times the irq
> storm happens like with auto cmd12 enabled - always after the first reboot.
> So it seems auto cmd12 is not the real reason for the error.
>
> Do you also encounter the second error later on (for me in udev stage):
> > ?mmcblk1boot0: retrying using single block read
> > ?mmc1: ADMA error
> > ?mmcblk1boot0: error -5 transferring data, sector 448, nr 32, card status
> > 0x900
> > ?end_request: I/O error, dev mmcblk1boot0, sector 448
> > ?Buffer I/O error on device mmcblk1boot0, logical block 56
> > ?mmcblk1boot1: retrying using single block read
> > ?mmc1: ADMA error
> > ?mmcblk1boot1: error -5 transferring data, sector 448, nr 32, card status
> > 0x900
> > ?end_request: I/O error, dev mmcblk1boot1, sector 448
>
>

I recently came back from vacation (which is why I didn't pitch in
before). Has there been any further update on this? I want to exclude
my EMMC partitioning changes as the possible culprit here.

A
