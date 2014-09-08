From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Sep 2014 11:50:25 -0700
Subject: [PATCH v3 1/2] Documentation: dt-bindings: add dt binding info
 for dwc2 dr_mode
In-Reply-To: <1407159942-7063-2-git-send-email-kever.yang@rock-chips.com>
References: <1407159942-7063-1-git-send-email-kever.yang@rock-chips.com>
 <1407159942-7063-2-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=WDv9Pxe+jSqsfARPvjxMWPfcVpPMk1wHCgOO8ePiCh3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Mon, Aug 4, 2014 at 6:45 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> Indicate that the generic dr_mode binding should be used for dwc2.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
> Changes in v3: None
> Changes in v2:
> - Split out dr_mode and rk3288 bindings.
>
>  Documentation/devicetree/bindings/usb/dwc2.txt | 2 ++
>  1 file changed, 2 insertions(+)

Are there any other changes you'd like for this patch (and the next
one that goes with it) before landing?

Thanks!

-Doug
