From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Feb 2014 15:39:27 -0800
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <1392100183-30930-3-git-send-email-kgene.kim@samsung.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <1392100183-30930-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAOesGMiWsWXkQkb-_VZGco0gKNZPsHf3ubR88y4Pt4-umk5_Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 10:29 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch adds support for Samsung GH7 SoC in arm64/Kconfig.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

The overhead of building one more device tree isn't very large, and I
don't see any other need to have a Kconfig entry per SoC at this time.
It's of course up to Catalin, but you might just want to always
compile all dts files instead.


-Olof
