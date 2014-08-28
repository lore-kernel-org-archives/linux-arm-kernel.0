From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 20:47:58 -0700
Subject: [PATCH 00/14] Support 64bit Cortex A57 based Exynos7 SoC
In-Reply-To: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140828034758.GA4972@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Naveen,

On Wed, Aug 27, 2014 at 03:14:16PM +0530, Naveen Krishna Chatradhi wrote:
> This patchset supports new Exynos7 Samsung SoC based on Cortex-A57.
> Exynos7 is a System-On-Chip (SoC) that is based on 64-bit
> ARMv8 RISC processor.

Your emails haven't threaded properly, so the series of patches are not
recognized as comments to the envelope (00/14) email. It makes it harder
to review them in order, and some mailers might not group them well.

> We tested these patches with the 
> "arm64: dts: add <dt-bindings/> symlink" change posted @
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224629.html

That means that these patches can't be picked up until a permanent
solution for that has gone in.


-Olof
