From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Dec 2017 17:08:37 -0800
Subject: [GIT PULL] Amlogic fixes for v4.15-rc (redo)
In-Reply-To: <7h7eu7p95w.fsf@baylibre.com>
References: <7h7eu7p95w.fsf@baylibre.com>
Message-ID: <20171203010837.chbvhkrhayfbnmsz@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 30, 2017 at 04:46:19PM -0800, Kevin Hilman wrote:
> Arnd, Olof,
> 
> A handful of minor v4.15 fixes for Amlogic family SoCs.  They're mostly
> DT, but some trivial non-DT stuff mixed in.  Let me know if you prefer
> those in separate pulls, and I will do so.
> 
> Thanks,
> 
> Kevin
> 
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git amlogic-fixes
> 
> for you to fetch changes up to 9f8e06ca1d0e3ef1167a2f43a8b1e63763b283b8:
> 
>   ARM64: dts: odroid-c2: Add HDMI and CEC Nodes (2017-11-30 15:30:09 -0800)
> 
> ----------------------------------------------------------------
> Amlogic fixes for v4.15-rc
> - GPIO interrupt fixes
> - new nodes for drivers merged late (VPU domains)

The VPU power domain and HDMI regulator changes look more like new hardware
support than bugfixes to me, is that a correct assessment? I.e. is something
breaking by not having these new DT nodes in the tree one existing hardware?

If it isn't a bugfix, I think I'd rather see it queued up for next merge
window


-Olof
