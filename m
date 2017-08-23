From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 11:55:11 +0200
Subject: [PATCH 2/2] soc/tegra: fuse: Add missing semi-colon
In-Reply-To: <20170823092509.5243-2-thierry.reding@gmail.com>
References: <20170823092509.5243-1-thierry.reding@gmail.com>
 <20170823092509.5243-2-thierry.reding@gmail.com>
Message-ID: <CAK8P3a0YuiyhCE7ar5ZMorvVPOsgvjeqULwRnRFiQeFM271MxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 11:25 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Commit 8a46828e623c ("soc/tegra: Register SoC device") added a new
> initcall, but forgot to terminate the line with a semi-colon. Some
> recent versions of GCC seem to report this as an error.
>
> Fixes: 8a46828e623c ("soc/tegra: Register SoC device")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied patches 1 and 2, thanks for addressing this so quickly!

       Arnd
