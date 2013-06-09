From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Jun 2013 22:35:26 -0700
Subject: [GIT PULL] SiRF fixes for the v3.10 series
In-Reply-To: <CAGsJ_4xTVms1wZVgBDE-+qZMGxKT4s_u-A=wXiB2Xq0NztpOUw@mail.gmail.com>
References: <CAGsJ_4xTVms1wZVgBDE-+qZMGxKT4s_u-A=wXiB2Xq0NztpOUw@mail.gmail.com>
Message-ID: <CAOesGMhSSYPQ6fUVDy+4Nj3s48HC=4Mny7m_kRCP4Cviq9rCbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 2, 2013 at 11:28 PM, Barry Song <21cnbao@gmail.com> wrote:
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
>
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
>
> are available in the git repository at:
>
>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git
> tags/sirf-arm-soc-v3.10-fixes
>
> for you to fetch changes up to 3cc3b617dc39dad1e566ccfc4500154cb7c51aa3:
>
>   arm: prima2: use of_platform_populate instead of
> of_platform_bus_probe (2013-06-03 13:51:58 +0800)


Hi,

Sorry for the delay in responding to this.

Looking at the patches, they don't seem to fix any regression or
serious bug -- they are more of cleanups and code removals. So I've
pulled them into next/fixes-non-critical for 3.11.


Thanks!

-Olof
