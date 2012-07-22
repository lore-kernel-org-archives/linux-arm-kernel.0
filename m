From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 22 Jul 2012 20:07:01 +0100
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120722095328.GB5423@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
Message-ID: <20120722190700.GD4557@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 11:53:28AM +0200, Andrew Lunn wrote:

> You can see the chain of dependencies here. So at minimum i would need
> to send the first three via Mark. I then need to cross my fingers and
> hope he really picks them up, because without them, we are going to
> have a number of boards which fail to find their root file system on
> an SPI flash.

Well, I'd like to think that generally I'm reasonably responsive to
patch submissions and obviously there's no great urgency here since
we're in the merge window - nothing is likely to go in until 3.7 anyway,
though it'd be handy if the DT updates went in early (and they're very
low risk...).

> Now, maybe i've done all this wrong, since i'm a newbie to collecting
> patches together for submission upstream....

The general pattern with these things should be that the patches get
sent via the normal route and any unusual requirements discussed then.
To be honest it doesn't seem like there's much problem here, you've got
no build time dependencies or anything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120722/03607612/attachment.sig>
