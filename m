From: andreiw@motorola.com (Andrei Warkentin)
Date: Mon, 20 Jun 2011 14:34:53 -0500
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <201106191623.48470.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de>
	<BANLkTinCyr=pL9tyK+F9XxX2r15acqEsNA@mail.gmail.com>
	<201106191623.48470.heiko@sntech.de>
Message-ID: <BANLkTi=FWsfFWQDKk4CbSB5JK5NXhVJZnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Sun, Jun 19, 2011 at 9:23 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Samstag 18 Juni 2011, 22:56:11 schrieb Daniel Mack:

The log you sent out seems a bit short (it's covers < 1s of boot time
- usb0: no IPv6 routers present is the last line ). Can you send -
1) A full log with errors without any of my patches.
2) A full log with just the first patch.
3) A full log with just the second patch.

I'm interested in knowing what the pattern of access to boot0 and
boot1 is that causes these failures - does it only report I/O errors
for for certain blocks (say, above some number) or for all of them.

A
