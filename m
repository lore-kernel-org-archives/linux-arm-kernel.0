From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Aug 2017 18:01:32 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.14
In-Reply-To: <cover.1501509815.git.horms+renesas@verge.net.au>
References: <cover.1501509815.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a2VnommvfALpR+q8Dh8sa421oF3z45ZH4W8s1qVjFo8zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 5:02 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:

> ----------------------------------------------------------------
> Renesas ARM64 Based SoC Defconfig Updates for v4.14
>
> * compile ak4613 and renesas sound as modules
>
>   This is intended to reduce the size of a kernel image compiled
>   using the defconfig. This is timely as it brings the kernel image
>   back below the size that can be booted in my environment, a limit
>   it crept over in v4.13-rc1.

Good idea, thanks! Pulled into next/arm64.

       Arnd
