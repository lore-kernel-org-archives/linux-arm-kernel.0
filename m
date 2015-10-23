From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Oct 2015 10:25:57 -0700
Subject: [resend GIT PULL] ARM: mediatek: arm64 updates for v4.3
In-Reply-To: <CABuKBeJbELoYh7fC_QNGgPxVHHhjioVn++z6Qj0W2X5Q-imL0g@mail.gmail.com>
References: <CABuKBeJbELoYh7fC_QNGgPxVHHhjioVn++z6Qj0W2X5Q-imL0g@mail.gmail.com>
Message-ID: <20151023172557.GK2224@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 18, 2015 at 02:23:40PM +0200, Matthias Brugger wrote:
> Hi Arnd and Olof,
> 
> Please pull the following patches.
> 
> I resend this pull request, because I forgot to add the arm mailing
> list in the first place.
> 
> Thanks,
> Matthias
> 
> ---
> 
> The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100fde:
> 
>   Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/mbgg/linux-mediatek.git tags/v4.3-next-arm64
> 
> for you to fetch changes up to e34573c95a1416b4f26a5cc68b1de198e6b27ad7:
> 
>   arm64: dts: mt8173: Add clocks for SCPSYS unit (2015-10-14 15:43:13 +0200)
> 
> ----------------------------------------------------------------
> Correct i2c DTS node names in mt8173.dtsi.
> 
> Add spi DTS node to the mt8173 and mt8173-evb.
> 
> Add dts nodes for the subsystem clocks on mt8173.
> This includes mmsys, imgsys, vdecsys, vencsys, vencltsys.
> 
> Add clock nodes to the scpsys binding, which are needed to
> access the registers of venc and venc_lt power domains.

Thanks, merged.


-Olof
