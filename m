From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Jan 2018 16:08:26 +0100
Subject: [PATCH] ARM: sunxi_defconfig: Enable CMA
In-Reply-To: <20180119133208.12873-1-maxime.ripard@free-electrons.com>
References: <20180119133208.12873-1-maxime.ripard@free-electrons.com>
Message-ID: <CAK8P3a1B5A0rXP7MvLp+wMokz=BjK8LA7eay3EmnTfn94TD2ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 2:32 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The DRM driver most notably, but also out of tree drivers (for now) like
> the VPU or GPU drivers, are quite big consumers of large, contiguous memory
> buffers. However, the sunxi_defconfig doesn't enable CMA in order to
> mitigate that, which makes them almost unusable.
>
> Enable it to make sure it somewhat works.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to fixes, thanks!

      Arnd
