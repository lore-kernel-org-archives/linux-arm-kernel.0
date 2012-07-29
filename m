From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jul 2012 13:44:53 -0700
Subject: [PULL REQUEST] ARM: Orion DT converstions
In-Reply-To: <20120727152236.GB31179@lunn.ch>
References: <20120727152236.GB31179@lunn.ch>
Message-ID: <CAOesGMi1mDyUDYV7abPU6Xd7bnoSKyZz6Zem0nBXkTPrm0v1Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 27, 2012 at 8:22 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Arnd, Olof
>
> Here is the pull request for Orion DT changes.
>
> I've not yet received an answer as to if the i2c-embedded branch is
> stable. So i rebuilt the branch without it. The patches themselves are
> identical, with our without.
>
> The spi-3.6 branch is also merged as a runtime dependency. I also
> merged my own v3.5-rc7-fixes, which you have already pulled. These are
> needed for the mrvl->marvell rename.
>
> Thanks
>         Andrew
>
> The following changes since commit 89fb2d77d5daa821e3868ea59963f28249974840:
>
>   Merge branch 'v3.5-rc7-fixes' into v3.5-rc7-dt-v3 (2012-07-27 16:45:25 +0200)
>
> are available in the git repository at:
>
>
>   git at github.com:lunn/linux.git v3.5-rc7-dt-v3

I pulled this from git://github.com/lunn/linux.git instead, please
make sure you use the public URL in the future.

I've pulled it in as late2/dt, if all looks good in -next I'll send it
up in a few days but no hard commitments since it was merged so late.


-Olof
