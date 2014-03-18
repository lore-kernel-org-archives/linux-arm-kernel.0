From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 18 Mar 2014 22:53:58 +0100
Subject: [PATCH v3 0/5] Add Broadcom Kona PWM Support
In-Reply-To: <20140314134324.GY25092@beef>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
 <20140314134324.GY25092@beef>
Message-ID: <20140318215357.GI5917@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 09:43:24AM -0400, Matt Porter wrote:
> On Wed, Mar 12, 2014 at 01:15:41PM -0700, Tim Kryger wrote:
> > This series introduces the driver for the Kona PWM controller found in
> > Broadcom mobile SoCs like bcm281xx and updates the device tree and the
> > defconfig to enable use of this hardware on the bcm28155 AP board.
> > 
> > Changes since v2:
> >   - SoC DTS file updated to use real clock's phandle + specifier
> >   - Toggle smooth mode off during apply so new settings take immediately
> > 
> > Changes since v1:
> >   - Fixed up macros to be clearer and more complete
> >   - Corrected spelling and punctuation mistakes
> >   - Added support for polarity
> >   - Made peripheral clock use more efficient
> >   - Made prescale and duty computation clearer
> >   - Moved Makefile addition to keep alphabetical
> >   - Split complex lines into multiple steps
> > 
> > Dependencies:
> > The "ARM: dts: Declare the PWM for bcm11351 (bcm281xx)" patch depends
> > upon "ARM: dts: bcm281xx: define real clocks" which is queued up in
> > for-next of arm-soc. See https://lkml.org/lkml/2014/2/14/451
> > 
> > Tim Kryger (5):
> >   Documentation: dt: Add Kona PWM binding
> >   pwm: kona: Introduce Kona PWM controller support
> 
> Thierry, are you planning to merge these first two for 3.15? If so, I
> will apply dts patches for my last mach-bcm 3.15 pull. I don't want to
> do so until the binding is accepted.

I've reviewed this and it doesn't look like 3.15 material.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/f1040b72/attachment.sig>
