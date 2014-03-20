From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 20 Mar 2014 15:59:35 +0100
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT
 documentation
In-Reply-To: <20140320143110.GU7528@n2100.arm.linux.org.uk>
References: <20140320092639.48F68A6279@smtp3-g21.free.fr>
 <532ADFD8.80301@gmail.com> <20140320140156.5d768b1f@armhf>
 <532AEDE2.3080306@gmail.com> <20140320145221.09252bf6@armhf>
 <20140320143110.GU7528@n2100.arm.linux.org.uk>
Message-ID: <20140320155935.7a474173@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 14:31:10 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> 1. change the DT compatible strings the driver has to accept both
>    nxp,tda19988 and nxp,tda19989, and set the appropriate device
>    in the DT file (tda19988).  I'm a bit nervous about using
>    "nxp,tda1998x" in case we're clashing with devices with different
>    characteristics.

The Cubox is sold with either the TDA19988 or the TDA19989 (I don't
know about the AMX33XX boards). Then, setting the exact type in the DT
would ask for 2 differents DTs or for having two tda998x definitions in
a same DT...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
