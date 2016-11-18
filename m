From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 10:38:33 -0800
Subject: [GIT PULL] arm64: dts: hisilicon dts updates for v4.10
In-Reply-To: <582B320F.7030206@hisilicon.com>
References: <582B320F.7030206@hisilicon.com>
Message-ID: <20161118183833.GK8882@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 04:04:31PM +0000, Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin,
> 
> Please help to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-4.10
> 
> for you to fetch changes up to 85f5bd9e771349833602ccdd39b65613ecd11fd1:
> 
>   arm64: dts: hisi: add refclk node to hip06 dts files for SAS (2016-11-15 10:58:41 +0000)
> 
> ----------------------------------------------------------------
> ARM64: DT: Hisilicon SoC DT updates for 4.10
> 
> - Correct the hardware pin number of the usb node on the Hip06
> - Add the Hisilicon Hip07 D05 board dts binding
> - Add the initial dts for the Hip07 D05 board
> - Fix the warning for the node without reg propery on the Hip06
> - Fix the sas am max transmissions quirk property on the Hip06
> - Disable the sas0 and sas2 on D03 board
> - Add refclk node for SAS on the Hip06

Merged, thanks.


-Olof
