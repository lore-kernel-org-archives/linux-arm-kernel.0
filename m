From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 20 Aug 2010 10:53:51 +0100
Subject: [PATCH v2] MAX8952 PMIC Driver Initial Release
In-Reply-To: <1282283036-12641-1-git-send-email-myungjoo.ham@samsung.com>
References: <1282283036-12641-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100820095351.GD13668@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 20, 2010 at 02:43:56PM +0900, MyungJoo Ham wrote:
> MAX8952 PMIC is used to provide voltage output between 770mV - 1400mV
> with DVS support. In this initial release, users can set voltages for
> four DVS modes, RAMP delay values, and SYNC frequency.
> Controlling FPWM/SYNC_MODE/Pull-Down/Ramp Modes and reading CHIP_ID
> is not supported in this release.
> 
> If GPIO of EN is not valid in platform data, the driver assumes that it
> is always-on. If GPIO of VID0 or VID1 is invalid, the driver pulls down
> VID0 and VID1 to fix DVS mode as 0 and disables DVS support.
> 
> We assume that V_OUT is capable to provide every voltage from 770mV to
> 1.40V in 10mV steps although the data sheet has some ambiguity on it.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
