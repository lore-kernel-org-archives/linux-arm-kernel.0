From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Fri, 15 Sep 2017 15:28:44 +0200
Subject: n900 in next-20170901
In-Reply-To: <20170907073038.GA2111@js1304-P5Q-DELUXE>
References: <20170903203737.GA12475@amd> <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
Message-ID: <20170915132844.GW32278@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 September 2017 16:30:38 Joonsoo Kim wrote:
> If it doesn't help, is there a way to test n900 configuration in QEMU?

Hi Joonsoo, linaro version of QEMU has support for n900 machine. For
more information how to prepare & run kernel image see this email:
https://lists.denx.de/pipermail/u-boot/2015-January/200171.html
(instead u-boot.bin you would supply kernel's zImage)

But QEMU does not support HS mode, so there is probably no secure ram.
IIRC smc instructions should not be used in normal GP mode.

-- 
Pali Roh?r
pali.rohar at gmail.com
