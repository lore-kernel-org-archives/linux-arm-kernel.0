From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 11:53:21 +0200
Subject: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
In-Reply-To: <CAFBinCA3PoR_=+f8aU-Trg8uKWWXkkBOtrQUaXbdsb8E-fdM0g@mail.gmail.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCA3PoR_=+f8aU-Trg8uKWWXkkBOtrQUaXbdsb8E-fdM0g@mail.gmail.com>
Message-ID: <20160905095321.GB31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2016 at 06:33:03PM +0200, Martin Blumenstingl wrote:
> On Mon, Aug 22, 2016 at 5:36 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> > Add support for the PWM controller found in the Amlogic SoCs.
> > This driver supports the Meson8b and GXBB SoCs.
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> I could enable the AP6330 SDIO wifi module with this on my
> meson-gxbb-vega-s95-meta clone, which uses pwm_e to generate the LPO
> clock for the wifi module (see [0] for the corresponding patches).
> So thank you Neil, and:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Hi Martin,

As mentioned in another reply in this thread I ended up restructuring
the driver a little before applying it to the PWM tree. I don't /think/
there are any functional changes, so I left your Tested-by in place, but
it would be great if you could retest and confirm, just to make sure.

The driver is in the for-4.9/drivers branch of the PWM tree:

	https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-4.9/drivers

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/6455a12d/attachment-0001.sig>
