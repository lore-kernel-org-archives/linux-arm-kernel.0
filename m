From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 10 Apr 2018 10:12:02 +0200
Subject: [PATCH v2 0/2] clk: at91: Added more information logging
In-Reply-To: <20180410001551.GA62208@hak8or>
References: <20180410001551.GA62208@hak8or>
Message-ID: <20180410101202.2abdf68f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin

On Mon, 9 Apr 2018 20:15:51 -0400
Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:

> This is a series of patches which resolves set_rate() for the PLL not
> having any effect and therefore the USB Host port not working. Also, a
> few messages were added which may be helpful in the future when others
> are working with USB clocking.

Can you please send patch series in a threaded manner (the cover
letter being the mail email and patches 1 to X being tagged as
'In-reply-to')? Normally, git send-email takes care of that for you if
you do

# git send-email *.patch

> 
> Changes since V1:
>   Added patch set cover letter
>   Shortened lines which were over >80 characters long
>   > Comment by Greg Kroah-Hartman about "from" field in email addressed
>   > Comment by Alan Stern about redundant debug lines addressed  
> 
> hak8or (2):
>   clk: at91: Added more information logging.
>   clk: at91: Fix for PLL set_rate changes not being actually written to
>     PLL peripheral bits
> 
>  drivers/clk/at91/clk-pll.c   | 14 +++++++++++++-
>  drivers/clk/at91/clk-usb.c   | 10 ++++++++--
>  drivers/usb/host/ohci-at91.c | 16 ++++++++++------
>  3 files changed, 31 insertions(+), 9 deletions(-)
> 
