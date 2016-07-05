From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Jul 2016 21:33:08 -0700
Subject: [GIT PULL] arm64: defconfig: juno updates for v4.8
In-Reply-To: <57697F93.4090904@arm.com>
References: <57697F93.4090904@arm.com>
Message-ID: <20160705043308.GJ1669@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 06:55:31PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Please pull !
> 
> -- 
> Regards,
> Sudeep
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
> tags/juno-defconfig-4.8
> 
> for you to fetch changes up to 2a0e527c7ed60f9c85233bfe69a9023798c1d428:
> 
>   arm64: defconfig: enable SENSORS_ARM_SCPI (2016-06-20 16:45:30 +0100)
> 
> ----------------------------------------------------------------
> ARMv8 Juno/Vexpress defconfig updates for v4.8
> 
> 1. Enable support for SCPI based sensors(temperature, voltage,
>    current and power)
> 
> 2. Enable the Generic on-chip SRAM driver. SRAM is used for SCPI based
>    communication with SCP on Juno

Thanks, merged.


-Olof
