From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 12:41:51 -0800
Subject: [GIT PULL 0/6] Tegra branches for 3.4
In-Reply-To: <1330892042-32065-1-git-send-email-olof@lixom.net>
References: <1330892042-32065-1-git-send-email-olof@lixom.net>
Message-ID: <CAOesGMgahK_wkM1PGb55D1gEzbYfJVQKO_XSqMPbw5wTP09Fag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 4, 2012 at 12:13 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi Arnd,
>
> Below are the 6 pull requests for Tegra platforms for 3.4. This is also
> likely my last merge request for tegra material (besides possibly some
> stray patches between now and the merge window), since I am handing off
> main maintainership to Stephen Warren for the next merge window.
>
> Each branch is documented in the tag (they are all tag pull requests), as
> well as in the emails below. Nothing too controversial.

Oh, I did forget to mention one added dependency: The soc-drivers
branch has a dependency on Grant's irq_domain branch -- not for
merging but for building.


-Olof
