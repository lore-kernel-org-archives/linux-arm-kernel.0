From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Jun 2015 22:18:29 +0200
Subject: [linux-sunxi] Re: [PATCH 00/20] ARM: dts: Add USB and OTG
 related nodes and enable on various boards
In-Reply-To: <CAOMqctRDEoPiJ95EVgs_ZRQVt=SzK9NPDJGmq3JTJF1kWscmqg@mail.gmail.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
 <20150608100358.GW23777@lukather>
 <CAOMqctRDEoPiJ95EVgs_ZRQVt=SzK9NPDJGmq3JTJF1kWscmqg@mail.gmail.com>
Message-ID: <20150609201829.GA8535@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 08, 2015 at 02:56:35PM +0200, Michal Suchanek wrote:
> Hello,
> 
> On 8 June 2015 at 12:03, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > Hi Hans,
> >
> > On Fri, Jun 05, 2015 at 09:02:03PM +0200, Hans de Goede wrote:
> >> Hi Maxime,
> >>
> >> Here is a patch-set with all the otg / sun8i-usb-host related dts patches
> >> I've accumulated.
> >>
> >> These are intended for 4.3, and go hand in hand with the outstanding
> >> musb-sunxi / phy-sun4i-usb patches, which I expect to be merged as is
> >> for 4.3 .
> >
> > I'm fine with these patches. Do you have a branch somewhere that I can
> > pull (without the one that you wanted me to drop, obviously)?
> 
> Are these before the conversion to DT label syntax or after (meaning
> that the conversion patches got pulled somewhere already)?

Yes. They've been in my tree for a few monthes now, and have been in
linux-next and arm-soc for quite some time too.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/254c4bf4/attachment.sig>
