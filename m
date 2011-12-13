From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Dec 2011 14:40:04 -0800
Subject: [GIT PULL] Two non-critical DMA fixes for v3.3 merge window
In-Reply-To: <20111212224648.GI32251@atomide.com>
References: <20111212224648.GI32251@atomide.com>
Message-ID: <CAOesGMgzbPSSfGZnaaLt3utjxVG82WCb8hEfbTzkcwqr3SXhfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 12, 2011 at 2:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Arnd & Olof,
>
> Please pull two non-critical DMA fixes from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical
>
> These are workarounds for corner cases. There's no rush
> to get them in during the -rc cycle, these are fixes for
> features that never worked before.

Thanks, pulled into next/fixes-non-critical (to avoid confusion with
the plain fixes branch for 3.2-rc).


-Olof
