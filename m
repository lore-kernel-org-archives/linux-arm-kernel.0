From: dianders@chromium.org (Doug Anderson)
Date: Thu, 5 Jun 2014 13:42:20 -0700
Subject: [PATCH v2] clk: exynos5420: Keep aclk66_peric enabled during boot
In-Reply-To: <CAD=FV=Ucn20GDib=t=OOT+8YjGuk6uoWrP1qourY=YfrLJj1WA@mail.gmail.com>
References: <1401398496-4624-1-git-send-email-dianders@chromium.org>
 <1401467562-5585-1-git-send-email-dianders@chromium.org>
 <CAD=FV=W8-M5iOMDG190WGaeSySTd=qcp30k-H8DMUs_C5Pdwog@mail.gmail.com>
 <5390C19A.9060201@gmail.com>
 <CAD=FV=UZsEh+bOQxc8CP+yG5a5Sbp2eTyq8B_iq9u5io5G0B6A@mail.gmail.com>
 <5390C5A9.5070900@gmail.com>
 <CAD=FV=Ucn20GDib=t=OOT+8YjGuk6uoWrP1qourY=YfrLJj1WA@mail.gmail.com>
Message-ID: <CAD=FV=XEqWTrRCPndLPuXnVeE_wLmDXCkgL-V95UZ0S1x4ppaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 5, 2014 at 1:10 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hmmm, I think I've convinced myself that your suggestion of just
> removing this gate from the table is the right thing to do.  Patch
> will be coming up soon.

It's here <https://patchwork.kernel.org/patch/4308631/>

Ironically, that patch has a much worse diffstat and also changes
devicetree bindings (!).  ...but it does seem better.

-Doug
