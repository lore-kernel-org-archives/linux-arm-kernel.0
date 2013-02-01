From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 14:43:24 +0530
Subject: [PATCH 00/10] ARM: OMAP5: hwmod, clock and prm data files
In-Reply-To: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <510B8734.2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Friday 18 January 2013 08:57 PM, Santosh Shilimkar wrote:
> Series contains the hwmod, clock and prm data files for OMAP54xx SOCs.
> This data was kept out of tree to be validated on es2.0 silicon version
> and also to avoid the es1.0/es2.0 differences which are many.
>
> Benoit Cousson, Rajendra Nayak, Paul Walmesly and Mike have all contributed
> to get the autogen scripts in shape for OMAP5.
>
>  From various discussion on the list, the clock data files are suppose
> to be moved to drivers/clk/. Once the direction is clear, patch 8
> can be updated accordingly.
>
> Patches are tested on OMAP5 sEVM and uEVM. For testing few additional patches
> are needed. Same tree can be fetched from here [1]
>
> The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
>
>    Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)
>
> are available in the git repository at:
>
>    git://github.com/SantoshShilimkar/linux.git for_3.9/omap5_data_files
>
> for you to fetch changes up to 7f534e1ebeb2bc64250b56fe00eb7d4dfa585e8e:
>
>    ARM: OMAP5: Enable build and frameowrk initialisations (2013-01-18 19:45:48 +0530)
>
> ----------------------------------------------------------------
>
> Benoit Cousson (7):
>    ARM: OMAP5: PRM: Add OMAP54XX register and bitfield files
>    ARM: OMAP5: CM: Add OMAP54XX register and bitfield files
>    ARM: OMAP5: PRCM: Add OMAP54XX local MPU PRCM registers
>    ARM: OMAP5: SCRM: Add OMAP54XX header file.
>    ARM: OMAP2+: clockdomain data: Add OMAP54XX data and update the
>      header
>    ARM: OMAP5: powerdomain data: Add OMAP54XX data and update the header
>    ARM: OMAP5: hwmod data: Create initial OMAP5 SOC hwmod data
>
> Rajendra Nayak (1):
>    ARM: OMAP5: clock data: Add OMAP54XX full clock tree and headers
>
> Santosh Shilimkar (2):
>    ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data
>    ARM: OMAP5: Enable build and frameowrk initialisations
>
As discussed on the list, I am going to drop the clock-data[7/10]
and build patch[10/10] and prepare a pull request. Let me know
if thats fine with you.

Regards,
Santosh
