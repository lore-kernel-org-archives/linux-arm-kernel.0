From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Fri, 28 Sep 2012 07:54:17 +0530
Subject: [PATCH] arm/omap: Replace board_ref_clock with enum values
In-Reply-To: <5063306E.8080200@gmail.com>
References: <5063306E.8080200@gmail.com>
Message-ID: <CADTbHxozV2UyJjWoDaK3acpDxbtDJDOoapiV19w3FSMZUdMtpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 26, 2012 at 10:12 PM, Vikram Narayanan <vikram186@gmail.com> wrote:
> Use the enum for board_ref_clock from linux/wl12xx.h
>
> Signed-off-by: Vikram Narayanan <vikram186@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> ---
> I'm not subscribed to the list. So please keep me in Cc for the replies.
>
>  arch/arm/mach-omap2/board-omap4panda.c       |    3 +--
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>

Looks good.

Reviewed-by: Pankaj Jangra<jangra.pankaj9@gmail.com>

--
Pankaj Jangra
