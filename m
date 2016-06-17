From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 17 Jun 2016 07:46:07 +0200
Subject: [PATCH] ARM: dts: sun8i: Add dts file for inet86dz board
In-Reply-To: <f080dda9-6410-ec79-f083-29a20d147d61@redhat.com>
References: <1465754150-16753-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v66cbx0jta1unrKeYm1t9JKO9Unw8z75rXbW3JSi2=NuMw@mail.gmail.com>
 <f080dda9-6410-ec79-f083-29a20d147d61@redhat.com>
Message-ID: <20160617054607.GN5144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 11:35:15AM +0200, Hans de Goede wrote:
> Hi
> 
> On 13-06-16 05:16, Chen-Yu Tsai wrote:
> >Hi,
> >
> >On Mon, Jun 13, 2016 at 1:55 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>The inet86dz board is a board used in 7" tablets from various oems.
> >>
> >>These tablets are a23 based 7" tablets featuring a 1024x600 LCD,
> >>512MB RAM, 4G NAND, rtl8188etv usb wifi, gsl1680 touchschreen,
> >>micro-sd slot, 3.5mm headphone jack and a micro-usb otg connector
> >>which doubles as charging port.
> >
> >This seems awfully similar to the sun8i-a23-q8-tablet, any reason
> >not to include that or sun8i-q8-common.dtsi?
> 
> So to answer this both for this board and for the Polaroid MID2407PXE03
> one, these are not q8 tablets, they are not using the standard q8 casing
> at least. So using q8 for them would seem to be a bit confusing to users
> and figuring out how to do proper autodetect is already hard enough without
> throwing these into the mix too.
> 
> OTOH you are right that there is a lot of code duplication here. Since I
> plan to start working on touchscreen autodetect soon-ish, let me see how
> that goes first.

For reference, I'm not really against having similar boards having
similar-yet-duplicated DT. This is just data, and sometimes trying to
factorise things also make it less trivial and easy to understand.

> Maxime can you drop the Polaroid MID2407PXE03 patch for now ?

Done.

Thanks,
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/d8d89bc0/attachment.sig>
