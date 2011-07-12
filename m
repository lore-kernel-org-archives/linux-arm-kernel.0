From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Jul 2011 14:18:40 -0700
Subject: [PATCH] ARM: tegra: remove mach/barriers.h
In-Reply-To: <1310331772-13310-1-git-send-email-ccross@android.com>
References: <1310331772-13310-1-git-send-email-ccross@android.com>
Message-ID: <CAOesGMjrV1nnkTZ3dxpA3Drm_zWT__WkdS9tZ0BtP2fT5c=Nrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 2:02 PM, Colin Cross <ccross@android.com> wrote:
> The barriers implemented in arch/arm/mach-tegra/mach/barriers.h
> are exactly the same as the default barriers implemented in
> arch/arm/include/asm/system.h. ?Remove barriers.h from Tegra,
> and don't select ARCH_HAS_BARRIERS.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
