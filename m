From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Oct 2015 14:38:48 +0200
Subject: [PATCH 0/3] ARM: dts: sun4i: USB DRC and voltage-scaling for
 pcDuino1/2
In-Reply-To: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <20151005123848.GL2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 04, 2015 at 09:58:45PM +0300, Siarhei Siamashka wrote:
> Hello,
> 
> This brings LinkSprite pcDuino1/2 boards up to date with the latest
> kernel features. And the first patch in this set is a bugfix for the
> PH3/PH6 pins misuse.
> 
> There is currently a single dts file for pcDuino1 and pcDuino2 boards.
> They obviously had been designed to be compatible with each other, but
> have some minor differences, as can be seen when comparing schematics:
>     https://s3.amazonaws.com/pcduino/Hardware/PC+Duino_V01-20130128.pdf
>     https://s3.amazonaws.com/pcduino/Hardware/v2/pcDuino_v2_sch.pdf

Usually, the way we handle this is simply by including just the other
DT that will only hold those differences.

What are those differences exactly ?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/cc585a0a/attachment.sig>
