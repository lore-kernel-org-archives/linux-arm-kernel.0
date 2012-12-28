From: olof@lixom.net (Olof Johansson)
Date: Fri, 28 Dec 2012 08:53:57 +0100
Subject: [GIT PULLv2] Fixes for sunXi for 3.8
In-Reply-To: <50DB44FB.30603@free-electrons.com>
References: <50DB44FB.30603@free-electrons.com>
Message-ID: <CAOesGMgSf4wCJDXG589Gif0VEsD4ppZJG=VqwC3YcopPDjQwEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 26, 2012 at 7:42 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Arnd, Olof,
>
> Here is the two fixes I sent previously rebased on top of 3.8-rc1.
>
> The first one add the support for the sunxi architecture in the multiplatform
> kernel, allowing to easily build a kernel that boots on the sun4i/sun5i
> supported boards.
>
> The second one fixes some compatible strings that were left behind in the
> previous compatible renaming patch, preventing the kernel from booting.

Pulled, thanks!


-Olof
