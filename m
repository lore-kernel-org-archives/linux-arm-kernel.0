From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Aug 2017 22:21:28 -0700
Subject: [GIT PULL] arm: mediatek: dts32 updates for v4.14
In-Reply-To: <c357cfa5-8464-8b94-caeb-4b48c2f42659@gmail.com>
References: <c357cfa5-8464-8b94-caeb-4b48c2f42659@gmail.com>
Message-ID: <20170830052128.GC14499@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 03:31:22PM +0200, Matthias Brugger wrote:
> Hi Olof and Arnd,
> 
> for v4.14 please take the following pull request into account.
> 
> Thanks,
> Matthias
> 
> ---
> 
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
> 
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/mbgg/linux-mediatek.git tags/v4.13-next-dts32
> 
> for you to fetch changes up to dfff569aaf8886dcc97b145a15f2213b4a4599e6:
> 
>   arm: dts: mt7623: cleanup binding file (2017-08-14 17:17:02 +0200)
> 
> ----------------------------------------------------------------
> - mt7623: add mt7623n and mt7623a plattform
> - add mt7623 based reference boards
> - mt7623: add usb3, ethernet, cpufreq,
> - Add banana-pi board
> - add mt6323 pmic
> - mt2701: add larb-id property to smi larb

Looks like with the subject confused for dts64, this branch didn't get merged
before. Merged it to next/dt now.


Thanks,

-Olof
