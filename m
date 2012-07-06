From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 6 Jul 2012 14:32:44 +0530
Subject: [PATCH 1/2] ARM: OMAP: board-4430sdp: MUX configuration for
 sys_nirq2
In-Reply-To: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com>
References: <1341564590-14024-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <CAMQu2gyZQGGVQQtidGwOCux-0hX=FmPVP+9Sej_VRrQMurd=mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2012 at 2:19 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> The sys_nirq2 is used for twl6040, make sure the pin is configured
> correctly.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
Should remove the boot-loader pin-muxing dependency.
Was this the reason, Audio had some issues on OMAP4430
SDP as reported by Russell ?

FWIW:
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
