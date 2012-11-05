From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 05 Nov 2012 13:41:54 +0100
Subject: [PATCH 0/2] Pinctrl muxing for the Crystalfontz boards
In-Reply-To: <20121105032057.GC26528@S2100-06.ap.freescale.net>
References: <1351958348-7327-1-git-send-email-maxime.ripard@free-electrons.com>
 <20121105032057.GC26528@S2100-06.ap.freescale.net>
Message-ID: <5097B412.7040003@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/11/2012 04:20, Shawn Guo a ?crit :
> On Sat, Nov 03, 2012 at 04:59:06PM +0100, Maxime Ripard wrote:
>> Hi all,
>>
>> This patch serie add the hogpins to explicitly mux the GPIOs used
>> across the device tree as such for the two Crystalfontz boards, and
>> make the gpio-led driver use pinctrl.
>>
>> This serie goes on top of the i2c-mux-gpios patches I sent on this
>> list.
> 
> I do not see that dependency at all, so just applied both patches.

Well, some of the pins muxed are for the muxer, thus the dependency,
but, after all, it will just work.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
