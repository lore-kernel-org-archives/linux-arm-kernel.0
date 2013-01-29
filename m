From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 15:38:22 -0800
Subject: [GIT PULL] vexpress: drivers for v3.9
In-Reply-To: <1359484450.8090.27.camel@hornet>
References: <1359484450.8090.27.camel@hornet>
Message-ID: <CAOesGMinJef-9OsKi0LGB0W6i73sgyUqhm2Mie4gyC2JLjnd1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Tue, Jan 29, 2013 at 10:34 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> Hi Arnd, Olof,
>
> The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
>
>   Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/drivers-for-3.9
>
> for you to fetch changes up to d299d4b5c95d37df0a8964930a3586f8d3cdb4ef:
>
>   arm: Move sp810.h to include/linux/amba/ (2013-01-29 18:13:24 +0000)
>
> ----------------------------------------------------------------
> Versatile Express related driver updates for 3.9:
> * Move sp810 header to a more generic location,
>   mainly to share it with arm64
> * Add pseudo-GPIO lines (and equivalent gpio LED definitions)
>   to control LEDs on vexpress motherboard.
>
> ----------------------------------------------------------------
> Catalin Marinas (1):
>       arm: Move sp810.h to include/linux/amba/
>
> Pawel Moll (1):
>       mfd: vexpress: Add pseudo-GPIO based LEDs

I can't find record of this patch ever having been posted (under that
subject at least) on any list I am on, including linux-arm-kernel and
linux-kernel.

You should at least post it to those lists, and cc the MFD maintainer.
And you should get his ack if you are going to merge this patch
through arm-soc instead of through his tree.


-Olof
