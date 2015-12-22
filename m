From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:28:11 -0800
Subject: [GIT PULL] ARM64: Xilinx ZynqMP DT changes for v4.5
In-Reply-To: <566EB3CC.6070701@monstr.eu>
References: <566EB3CC.6070701@monstr.eu>
Message-ID: <20151222192811.GT30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 01:19:24PM +0100, Michal Simek wrote:
> Hi,
> 
> please pull this one patch to your tree. Move patches will come for 4.6.
> 
> Thanks,
> Michal
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-dt-for-4.5
> 
> for you to fetch changes up to bdd5739008617c594ac231b1427d23f2c9000fcd:
> 
>   ARM64: zynqmp: DT: Add interrupt-controller property to GPIO
> (2015-12-14 09:48:20 +0100)

Merged, thanks.


-Olof
> ----------------------------------------------------------------
> Soren Brinkmann (1):
>       ARM64: zynqmp: DT: Add interrupt-controller property to GPIO

ARM64 uses arm64: as prefix so please switch over in the
future. Confusing, I know. :)


-Olof
