From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 May 2014 17:14:26 +0100
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
In-Reply-To: <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
References: <537F3610.3050104@redhat.com>
 <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com>
 <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
Message-ID: <20140526161426.GK22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 06:07:18PM +0200, Ulf Hansson wrote:

> >> I'm not sure I'm buying the idea that we have a powerup driver that's
> >> meaningfully not part of the main device driver.

> I am having a bit hard to follow the terminology here. :-) What is a
> "powerup driver" and what is a "main device driver" in this context?

Yes, that's mostly what I'm saying as well.  The main device driver is
the driver that will bind to the SDIO device and control it, the powerup
driver is the separate bit of code which will ensure that device is
powered up - calling it a device driver seems a bit of a misnomer to me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140526/c44629f8/attachment.sig>
