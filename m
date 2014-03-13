From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 13 Mar 2014 11:08:38 +0100
Subject: [PATCH 1/2] ARM: dts: berlin2q: add the Marvell Armada 1500 pro
 (BG2Q) device tree
In-Reply-To: <532180E0.9060108@gmail.com>
References: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
 <1394622364-6848-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140312122210.GA3040@piout.net> <532180E0.9060108@gmail.com>
Message-ID: <20140313100838.GA4418@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/2014 at 09:56:48 +0000, Sebastian Hesselbarth wrote :
> On 03/12/2014 12:22 PM, Alexandre Belloni wrote:
> >
> >The 25MHz crystal is on the board, please move it to the board dts.
> 
> If you can confirm that sysmgr clock comes directly from this crystal,
> I agree. If it is fed into a pll and can possibly be modified or gated,
> make it depend on a 25MHz board crystal. If 25MHz is the only option
> for this clock input, I could also live with it being part of the SoC
> description.
> 

Yeah, after more discussion, the 25 MHz crystl is the only option and it
is fed to an oscillator that generate the reference clock for the PLLs.
It is probably fine to let it in the dtsi.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
