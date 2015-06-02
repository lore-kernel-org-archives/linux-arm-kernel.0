From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Jun 2015 10:14:59 +0200
Subject: [PATCH v2 6/6] ARM: sun8i: dts: Add Ippo-q8h v1.2 with A33 and
 1024x600 lcd support
In-Reply-To: <1432997706-20172-7-git-send-email-hdegoede@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
 <1432997706-20172-7-git-send-email-hdegoede@redhat.com>
Message-ID: <20150602081459.GO23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 30, 2015 at 04:55:06PM +0200, Hans de Goede wrote:
> The Ippo-q8h is a tablet circuit board commonly found in cheap Android
> tablets. The v1.2 version can be used with either an A23 or A33 SoC.
> 
> This adds a dts file for the v1.2 board with an A33 SoC and a 1024x600
> LCD screen (most of these tablets have a 800x480 screen).

I think the difference between the resolution here is more of a case
for the DT quirks interface:
https://lkml.org/lkml/2015/2/18/258

Do you know if there's some way to autodetect the two board versions
(like a board id somewhere in an EEPROM)?

If not, then maybe u-boot can simply add that board compatible to the
list, and we'll base our logic on that when we'll need it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/5112db89/attachment-0001.sig>
