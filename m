From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Aug 2017 10:58:18 +0200
Subject: [GIT PULL 1/3] ARM: Keystone DTS for 4.14
In-Reply-To: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
References: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
Message-ID: <CAK8P3a3P=ncdJo-weht5fdoKeNBH-k2xvf4s-uQaS+fMhNBarg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 2:30 AM, Santosh Shilimkar <ssantosh@kernel.org> wrote:
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.14
>
> for you to fetch changes up to 6794d3771c319bd67f95575f11846a0fe86105c5:
>
>   ARM: dts: keystone-k2g-ice: Add and enable DSP CMA memory pool (2017-08-12 10:58:11 -0700)
>
> ----------------------------------------------------------------
> ARM: Keystone DTS for 4.14
>
> Contents:
> - ti-sci power domain, clock and reset controller support
> - DSP nodes for k2h/k2l/k2e evms
> - DSP CMA memory pools for k2h/k2l/k2e/keg evms
> - MMC/hsmmc suport for k2g
> - eDMA support for k2g
> - DCAN support for k2g

Pulled into next/dt, thanks!

       Arnd
