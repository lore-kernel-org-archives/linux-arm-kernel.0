From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 17:03:58 +0200
Subject: [linux-sunxi] Re: [PATCH 4/6] ARM: dts: sun7i: Enable USB DRC on
 pcDuino 3
In-Reply-To: <55D58381.7040801@redhat.com>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
 <1439563477-12295-5-git-send-email-hdegoede@redhat.com>
 <20150820064545.GM30520@lukather> <55D58381.7040801@redhat.com>
Message-ID: <20150820150358.GZ30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 09:36:33AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 08/20/2015 08:45 AM, Maxime Ripard wrote:
> >On Fri, Aug 14, 2015 at 04:44:35PM +0200, Hans de Goede wrote:
> >>From: Jelle van der Waa <jelle@vdwaa.nl>
> >>
> >>Enable the otg/drc usb controller on the pcDuino 3.
> >>
> >>Note this board has the otg-vbus connected directly to the 5v-dcc of
> >>the board, so there is no vbus0 regulator, nor vbus0-det.
> >
> >Can it do OTG then?
> 
> Yes.
> 
> >If VBUS is tied to the 5v, there's no way for the
> >board to shut it down when acting as peripheral, right?
> 
> Correct, the idea is to power it over otg when using it
> as a peripheral, or at least power it from a usb port of
> the machine for which it is a peripheral. Note that the
> original cubieboard (both A10 and A20 versions) have the
> same issue.

Hmmm, I see. I'll queue your patch then.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/ecf37948/attachment.sig>
