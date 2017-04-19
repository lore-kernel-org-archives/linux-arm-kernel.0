From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 05:31:35 -0700
Subject: [GIT PULL 1/2] SoCFPGA DTS updates for v4.12
In-Reply-To: <1491404489-10411-1-git-send-email-dinguyen@kernel.org>
References: <1491404489-10411-1-git-send-email-dinguyen@kernel.org>
Message-ID: <20170419123135.GM17004@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 10:01:28AM -0500, Dinh Nguyen wrote:
> Hi Arnd, Kevin, and Olof:
> 
> Please pull in these DTS updates for v4.12.
> 
> Thanks,
> Dinh
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.12
> 
> for you to fetch changes up to 7fed0cbffe1db3383ae1900fffc8f4e14d2735c8:
> 
>   ARM: dts: socfpga: Add Devkit A10-SR Reset Controller (2017-03-16 07:57:16 -0500)
> 
> ----------------------------------------------------------------
> SoCFPGA DTS updates for v4.12
> - Clean-up:
> 	- Add clock/memory nodes
> 	- Add labels for CPU nodes
> 	- Remove unused unit names and reg
> 	- Remove unused skeleton.dtsi
> - Add support for PMU
> - Add QSPI for sodia board
> - Add Reset controller for Arria10

Merged, thanks!


-Olof
