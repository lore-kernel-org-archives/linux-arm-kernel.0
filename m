From: albert.u.boot@aribaud.net (Albert ARIBAUD)
Date: Tue, 14 Jan 2014 13:08:01 +0100
Subject: [PATCH v1 0/24] Zynq DT changes
In-Reply-To: <cover.1388743861.git.michal.simek@xilinx.com>
References: <cover.1388743861.git.michal.simek@xilinx.com>
Message-ID: <20140114130801.0f4ea12b@lilith>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Fri,  3 Jan 2014 11:10:45 +0100, Michal Simek
<michal.simek@xilinx.com> wrote:

> Hi,
> 
> this is respin of Jagan v3 series sent here
> http://lists.denx.de/pipermail/u-boot/2013-December/169617.html
> + 2 patches v4
> http://lists.denx.de/pipermail/u-boot/2013-December/169753.html
> http://lists.denx.de/pipermail/u-boot/2013-December/169752.html
> 
> The purpose of this series was to synchronized configuration
> which we are using with mainline version with adding features
> which we are using.
> 
> The major change, which I have done, is adding DT support for
> all zynq boards instead of board specification configurations.
> I have changed serial, gem, emaclite, mmc.
> i2c, spi already support bus selection.
> 
> For more information please look at patches.
> 
> All series are available here for easier testing.
> http://git.denx.de/?p=u-boot/u-boot-microblaze.git;a=shortlog;h=refs/heads/zynq
> 
> Thanks,
> Michal

As Jagan's series has been pulled in, can you resubmit a v2 based on
current ARM ToT?

Amicalement,
-- 
Albert.
