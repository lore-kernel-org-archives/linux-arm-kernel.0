From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Jul 2018 15:05:42 -0700
Subject: i.MX fixes for 4.18, round 3
In-Reply-To: <20180719074844.GW4576@dragon>
References: <20180719074844.GW4576@dragon>
Message-ID: <CAOesGMjJB4p9hK34Odh6fm+WLH8=BFQ3xLw+m-qKqnpPasN9Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 12:48 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 2ceb2780b790b74bc408a949f6aedbad8afa693e:
>
>   ARM: imx_v4_v5_defconfig: Select ULPI support (2018-07-03 21:12:04 +0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.18-3
>
> for you to fetch changes up to de2d9b5284bcb5c159c5882ac69f6bfd4dec7c67:
>
>   soc: imx: gpc: restrict register range for regmap access (2018-07-19 10:24:00 +0800)
>
> ----------------------------------------------------------------
> i.MX fixes for 4.18, round 3:
>  - Restrict GPC driver on register range that is accessible by regmap,
>    so that we can avoid user space from triggering imprecise external
>    abort exception.

Thanks, merged!


-Olof
