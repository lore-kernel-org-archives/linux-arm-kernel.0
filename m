From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 12 Mar 2014 18:16:52 -0300
Subject: [PATCHv14][ 4/4] ARM: dts: imx25: mbimxsd25: Add displays support.
In-Reply-To: <20140312220756.02f5b006@e6520eb>
References: <1390410577-22073-1-git-send-email-denis@eukrea.com>
 <1390410577-22073-4-git-send-email-denis@eukrea.com>
 <CAOMZO5AHdTbCQUPGjQaK0v6KJR3+fTN9Pb1sqaYwuKXgfK5U5g@mail.gmail.com>
 <20140312184048.4b6dbb21@e6520eb>
 <CAOMZO5Dux0Cq9desLAotznLa0=kznFPyPvAHKtida6y3gC6SQQ@mail.gmail.com>
 <20140312220756.02f5b006@e6520eb>
Message-ID: <CAOMZO5Cxvc3-brgKNCq8RXsjcj==7Ne+avgT_EVXrAAFSVDmUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, Mar 12, 2014 at 6:07 PM, Eric B?nard <eric@eukrea.com> wrote:

> if you have an oscilloscope, can you probe PIXCLK, HSYNC, VSYNC and DE
> to check the signals are properly configured vs the datasheet of your
> display.

Yes, I have measured VSYNC and there is no activity on this line.

Also tried 3.13 with a non-dt kernel and the same issue is seen.

Running FSL 2.6.31 I can see VSYNC at 57Hz and Tux on the display, so
the hardware is good.

At least for me imxfb seems to be broken even for the non-dt case.

Regards,

Fabio Estevam
