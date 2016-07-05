From: kyle@infradead.org (Kyle McMartin)
Date: Tue, 5 Jul 2016 09:43:23 -0400
Subject: pull request: lunux-firmware: Add Mediatek MT8173 VPU firmware
In-Reply-To: <1467629314-31902-1-git-send-email-andrew-ct.chen@mediatek.com>
References: <1467629314-31902-1-git-send-email-andrew-ct.chen@mediatek.com>
Message-ID: <20160705134323.GC8680@merlin.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 06:48:34PM +0800, Andrew-CT Chen wrote:
> Hi linux-firmware maintainers,
> 
> The following changes since commit 3ef7857d511ce6a91c5ce609da76c4702651cfa5:
> 
>   amdgpu: update polaris ucode (2016-06-28 14:31:11 -0400)
> 
> are available in the git repository at:
> 
>   https://github.com/andrewct-chen/vpu-linux-firmware.git vpu_encode
> 
> for you to fetch changes up to 40876d7b3c911161ab71bc84a6e90f257a13cdc4:
> 
>   mediatek: Add mt8173 VPU firmware (2016-07-04 16:26:54 +0800)

Pulled, thanks.

regards, --Kyle

> 
> ----------------------------------------------------------------
> Andrew-CT Chen (1):
>       mediatek: Add mt8173 VPU firmware
> 
>  WHENCE    |   19 +++++++++++++++++++
>  vpu_d.bin |  Bin 0 -> 4084848 bytes
>  vpu_p.bin |  Bin 0 -> 131036 bytes
>  3 files changed, 19 insertions(+)
>  create mode 100644 vpu_d.bin
>  create mode 100644 vpu_p.bin
> 
