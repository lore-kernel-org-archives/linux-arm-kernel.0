From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Nov 2017 16:17:10 +0100
Subject: [GIT PULL 3/7] soc/tegra: Changes for v4.15-rc1
In-Reply-To: <20171020115603.9828-3-thierry.reding@gmail.com>
References: <20171020115603.9828-1-thierry.reding@gmail.com>
 <20171020115603.9828-3-thierry.reding@gmail.com>
Message-ID: <CAK8P3a30rfx6VWmwP0TZWYMLmnJh2+NZziO0QaDaJWOw_gHJjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 1:55 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Hi ARM SoC maintainers,
>
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
>
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.15-soc
>
> for you to fetch changes up to 775dba87f891e99c2f46df17edd5f5359d0883ad:
>
>   soc/tegra: bpmp: Check BPMP response return code (2017-10-19 16:33:57 +0200)
>
> This pulls in a part of the tegra-for-4.15-firmware tag to resolve a
> build time dependency.
>
> Thanks,
> Thierry
>
> ----------------------------------------------------------------
> soc/tegra: Changes for v4.15-rc1
>
> Contains a fix to the generic power domain driver to properly report
> errors propagated from BPMP.

Pulled into next/drivers, thanks!

       Arnd
