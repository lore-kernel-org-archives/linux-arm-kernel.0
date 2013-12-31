From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 31 Dec 2013 17:13:57 +0100
Subject: Openblocks AX3-4 i2c bus lockup
In-Reply-To: <52C2D36C.8020905@free-electrons.com>
References: <20131221164151.GF20115@lunn.ch>
 <CADx9zJDbzUmgHCRn9K=8m_d_uiSAYoW3y_NVfLFiDq4WzS3C0A@mail.gmail.com>
 <52C2A5C8.7040201@free-electrons.com>
 <52C2B889.4030903@free-electrons.com> <52C2BD9A.9080303@gmail.com>
 <20131231133333.GV19878@titan.lakedaemon.net>
 <52C2D36C.8020905@free-electrons.com>
Message-ID: <20131231171357.2b23febf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 31 Dec 2013 15:23:40 +0100, Gregory CLEMENT wrote:

> My plan is:
> 
> First introducing a new compatible string and handle it in the driver.
> Theses patches will be simple and small enough to be applied on the
> current rc kernel and the stable kernels. I will also add a new dts
> file: armada-xp-a0-openblocks-ax3-4.dts (and maybe introduce adding
> also a armada-xp-common-openblocks-ax3-4.dtsi file). A0 SoCs are no
> more shipped, that's why I try to provide a solution which uses the B0
> SoC by default and which makes the A0 the exception.

I personally don't think it's worth spending time on doing a separate
DT for this, and that we should go directly to the solution that
runtime detects the SoC revision instead.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
