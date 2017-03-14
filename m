From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Mar 2017 08:05:45 -0700
Subject: [PATCH 2/4] ARM: dts: dm8168-evm: add the external reference
 clock for SATA
In-Reply-To: <CAMpxmJW5f5foYbFv_FsQPibDamT4hCJSywnELdLmXpQg_oKohQ@mail.gmail.com>
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
 <1489423399-3824-3-git-send-email-bgolaszewski@baylibre.com>
 <20170313213405.GX20572@atomide.com>
 <CAMpxmJW5f5foYbFv_FsQPibDamT4hCJSywnELdLmXpQg_oKohQ@mail.gmail.com>
Message-ID: <20170314150545.GB20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bartosz Golaszewski <bgolaszewski@baylibre.com> [170314 08:03]:
> 2017-03-13 22:34 GMT+01:00 Tony Lindgren <tony@atomide.com>:
> > * Bartosz Golaszewski <bgolaszewski@baylibre.com> [170313 09:45]:
> >> This board has an external oscillator supplying the reference clock
> >> signal for SATA. Its rate is fixed at 100Mhz. Add a corresponding
> >> device tree node.
> >
> > Is this the 100MHz clock from PCIe? Just like on dm814x-evm as noted
> > in the workaround thread below:
> >
> > http://e2e.ti.com/support/dsp/davinci_digital_media_processors/f/716/p/181083/671141
> >
> > Regards,
> >
> > Tony
> >
> 
> Hi Tony,
> 
> these signals come from a TI CDCM61002 (U30 on the board's
> schematics). It's hardwired to 100mHZ output.

Oh OK thanks.

Tony
