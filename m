From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jun 2017 13:44:36 +0200
Subject: [GIT PULL] ZTE arm64 device tree updates for 4.13
In-Reply-To: <20170621113220.GB3372@dragon>
References: <20170621113220.GB3372@dragon>
Message-ID: <CAK8P3a1oguWGCxQPsdDKu-vYhgJBpwk8pQXNrMDO9fc075P+VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 1:32 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-dt64-4.13
>
> for you to fetch changes up to 61c9e029912d4962c52361f0f7cb5f77c405f08b:
>
>   arm64: dts: zte: Use - instead of @ for DT OPP entries (2017-06-21 19:05:38 +0800)
>
> ----------------------------------------------------------------
> ZTE arm64 device tree updates for 4.13:
>  - Fix DTC unit_address_vs_reg warnings in OPP entries by replacing
>    '@' with '-' as the OPP nodes will never have a "reg" property.
>

Pulled into next/dt64, thanks!

      Arnd
