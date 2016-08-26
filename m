From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Aug 2016 11:34:02 +0200
Subject: [PATCH] ARM: dts: kirkwood: Fix PCIe label on OpenRD
In-Reply-To: <20160822164220.GB20029@lunn.ch> (Andrew Lunn's message of "Mon,
 22 Aug 2016 18:42:20 +0200")
References: <20160822160936.24873-1-gregory.clement@free-electrons.com>
 <20160822164220.GB20029@lunn.ch>
Message-ID: <87poovj2lx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On lun., ao?t 22 2016, Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Aug 22, 2016 at 06:09:36PM +0200, Gregory CLEMENT wrote:
>> While converting PCIe node on kirkwood by using label, the following
>> commit eb13cf8345e9 ("ARM: dts: kirkwood: Fixup pcie DT warnings")
>> introduced a regression on the OpenRD boards: the PCIe didn't work
>> anymore. As reported by Aaro Koskinen, the display/framebuffer was
>> lost. This commit adds the forgotten label.
>> 
>> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Fixes: eb13cf8345e9 ("ARM: dts: kirkwood: Fixup pcie DT warnings")
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/fixes

Thanks,

Gregory
>
>     Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
