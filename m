From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 Mar 2012 10:08:57 -0800
Subject: [GIT PULL 3/4] Samsung devel-mmc for v3.4
In-Reply-To: <4F5B7C8D.5000805@samsung.com>
References: <4F5B7C8D.5000805@samsung.com>
Message-ID: <CAOesGMgx-86rUuOfjTN8BeYZD+S=04oj+N9u-m9dr8JQA1Oxiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Mar 10, 2012 at 8:08 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd, Olof
>
> This is regarding Samsung mmc for v3.4.
>
> As a note, v3.4-for-cjb branch is merged into mmc/mmc-next like following:
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=fcd9bdae386753531a9cb6b2577359a83f4e121c

Looking at this series, there's really only one patch that is not in
the mmc tree:

ARM: SAMSUNG: change the name from s3c-sdhci to exynos4-sdhci

And all it does is change the platform device string contents.

Since there are no build-time dependencies between this and the MMC
change, I suggest you send only this patch so that we avoid having
merge dependencies where not strictly needed.

Would that be OK with you? If so, please send a fresh pull request
with only the above change in it.



Thanks,

-Olof
