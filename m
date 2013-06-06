From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Thu, 06 Jun 2013 02:15:56 +0200
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDyO+Sc1aQ64HBeh1OSzmPNsnwMwEo5kbHSan5vw_YEjXA@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
 <CAPweEDxMpeJc-w=Yd7d2OT=UisRBp2rxf-MPMDUCOG3EyJz1GQ@mail.gmail.com>
 <CAKON4OxwyV2f_iTEb5RnP_azc7EsSxPdku_TY5WLWxN7USiY1Q@mail.gmail.com>
 <CAPweEDw1BabE0cmT5fxZ3Z9p9EH508M3Nzcqk2VcO0oz-qYsvg@mail.gmail.com>
 <CAKON4Oz79hUE_ReAqjeynwL6ZWntX2W1uw3YOg0G2AiY7Gjs=g@mail.gmail.com>
 <CAPweEDyO+Sc1aQ64HBeh1OSzmPNsnwMwEo5kbHSan5vw_YEjXA@mail.gmail.com>
Message-ID: <1370477756.20454.65.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tor 2013-06-06 klockan 00:52 +0100 skrev luke.leighton:
> > How is the Allwinner kernel going to load the driver for the pca9532?
> > The mainline pca9532 driver does not understand fex so it can't read
> > the necessary initialization data.
> 
>  jon: you're immediately outside of the target market for which
> allwinner designed and deployed script.fex.

You missed the point. Mainlne Kernel drivers do take advantege of DT to
ease their bindings and configuration, much further than the fex can
express.

The exact same thing is experienced in designing a tablet. You add a
pheriperal device, and it needs to be configured somehow. DT does this
and it integrated in the kernel framework. fex also attemtps in doing
part of this, but lacks integration and requires much more driver
patching to fly.

And I don't see how you can say that pca9532 is off the grid in the
target market. It would fit nicely as a key backlight / edge colour
controller in a tablet to give the tablet a personal touch.

> > fex is only supported on the small number of peripheral chips
> > Allwinner has blessed. Use any chip outside of that set and it isn't
> > going to boot.
> 
>  eeexactly.  i did say "target market".

Yes you repeat that over an over. But what does it mean?

I think what you really mean is something else more in the line of "ODMs
not allowed to step outside a very narrow range of possible designs or
using less than a handful approved providers", typical lockin
conditions. I don't know what you really mean here, only that it's not
"target market".

Regards
Henrik
