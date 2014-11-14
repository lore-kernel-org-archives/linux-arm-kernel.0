From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 14 Nov 2014 23:05:29 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <201411141834.19242@pali>
References: <20141104205117.GA17606@amd> <5465A977.4030605@gmail.com>
 <20141114172008.GB12250@earth.universe> <201411141834.19242@pali>
Message-ID: <20141114220529.GA18566@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 14, 2014 at 06:34:18PM +0100, Pali Roh?r wrote:
> Anyway what is /dev/cmt_speech doing? If it exports gsm voice 
> call data, [...]

Right.

> [...] should not it have alsa snd interface?

Sounds also like a promising standardized kernel interface.
I wonder why a custom interface has been chosen in the first
place.

> V4L2 interface is not for video/camera/capture/tv cards?

The V4L2 interface is also used for radio interfaces (e.g. the
N900's fm receiver/transmitter) and for software defined radio.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/38ed5f3a/attachment.sig>
