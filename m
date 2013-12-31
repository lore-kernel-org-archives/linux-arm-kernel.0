From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Dec 2013 14:00:06 +0100
Subject: [PATCH v2 2/5] input: sun4i-ts: Add support for temperature sensor
In-Reply-To: <20131228011304.GB14188@core.coreip.homeip.net>
References: <1388156399-29677-1-git-send-email-hdegoede@redhat.com>
 <1388156399-29677-3-git-send-email-hdegoede@redhat.com>
 <20131228011304.GB14188@core.coreip.homeip.net>
Message-ID: <20131231130006.GW3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 27, 2013 at 05:13:04PM -0800, Dmitry Torokhov wrote:
> On Fri, Dec 27, 2013 at 03:59:56PM +0100, Hans de Goede wrote:
> >  
> > +Optional properties:
> > + - ts-attached: boolean set this to tell the driver that an actual touchscreen
> > +		is attached and that it should register an input device,
> > +		without this it only registers the builtin temperate sensor
> 
> I believe the guidance is to avoid describing kernel behavior in DT
> property so I think it should say:
> 
>  - ts-attached: boolean indicating that an actual touchscreen is
> 		attached to the controller.

Custom properties are also supposed to be prefixed by the vendor prefix.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131231/249f9270/attachment-0001.sig>
