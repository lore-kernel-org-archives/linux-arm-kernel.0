From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2018 10:36:44 -0700
Subject: [GIT PULL] SoCFPGA DTS updates for v4.20
In-Reply-To: <1536076668-21412-1-git-send-email-dinguyen@kernel.org>
References: <1536076668-21412-1-git-send-email-dinguyen@kernel.org>
Message-ID: <CAOesGMjxGcjszxPB4ec0mAi2UZYic13s4k4KzUvTQmj+FS2G7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 4, 2018 at 8:57 AM, Dinh Nguyen <dinguyen@kernel.org> wrote:
> Hi Arnd, Kevin, and Olof:
>
> Please pull in these SoCFPGA DTS updates for v4.20.
>
> Thanks,
> Dinh
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.20_part1
>
> for you to fetch changes up to 202eb5481421040e115526b75317b5ca72584806:
>
>   ARM: dts: socfpga: Rename socfpga_cyclone5_de0_{sockit,nano_soc} (2018-08-30 08:38:26 -0500)
>
> ----------------------------------------------------------------
> SoCFPGA DTS updates for v4.20
> - Rename de0_sockit to de0_nano_soc
> - Update NAND clocking
> - Set timer interrupt to edge sensitive
> - Stratix10 platform updates
>   - Update devkit with correct i2c clock

Merged, thanks!


-Olof
