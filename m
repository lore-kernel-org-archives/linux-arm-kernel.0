From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Nov 2015 08:44:48 +0100
Subject: [PATCH] ARM: dts: sun8i-h3-orangepi-plus: Enable USB host
 controllers
In-Reply-To: <564F3077.7020104@redhat.com>
References: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
 <1447616777-24660-5-git-send-email-hdegoede@redhat.com>
 <CAGb2v669Cu6+G=P8yH-g5KbOsWTHBgnYUYf2fGt+jKXbqVAKfQ@mail.gmail.com>
 <56498FA8.3050908@redhat.com> <564B51D7.7090500@gmail.com>
 <564F3077.7020104@redhat.com>
Message-ID: <20151124074448.GI32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

On Fri, Nov 20, 2015 at 03:38:47PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 17-11-15 17:12, Jens Kuske wrote:
> >Enable the 2 USB host controllers used on the Orange Pi Plus
> >and add the necessary regulators.
> >
> >Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> >Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> >---
> >
> >Hi Hans,
> >
> >with these regulators USB works on the Orange Pi Plus too.
> >I don't know if adding the regulators in the dts is okay, since most
> >regulators are defined in the sunxi-common-regulators.dtsi, but
> >we use different pins.
> 
> Thanks, I've added this to my sunxi-wip branch for now.
> 
> Regards,
> 
> Hans
> 
> p.s.
> 
> Any progress on getting the "core" H3 kernel support upstream ?
> 
> Given Arnd's remarks about how we should not hard-code the
> indices in the clk driver + the very KISS nature of the
> change to 1 parent-clk per gate setup I still believe
> that that one is best.
> 
> Maxime ? Chen-Yu ? It would be really good to be able to
> move forward with this, how do you want to proceed ?

Yeah, sorry, Chen-Yu and I were busy because of $LIFE the past weeks,
we're getting back to speed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/481c4023/attachment.sig>
