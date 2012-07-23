From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 10:37:47 +0100
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120723072749.GA18778@lunn.ch>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
 <20120722224241.GH4557@opensource.wolfsonmicro.com>
 <20120723072749.GA18778@lunn.ch>
Message-ID: <20120723093747.GD4435@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 09:27:49AM +0200, Andrew Lunn wrote:

> Will you accept any patches for this merge window? As you said, the DT
> enablement is low risk. It should be possible to separate this one
> patch from the other two.

Can you send the patches please?

The bit I was saying was most low risk was the actual DT changes, as
opposed to the bits that parse and use the DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/7bfedb4b/attachment.sig>
