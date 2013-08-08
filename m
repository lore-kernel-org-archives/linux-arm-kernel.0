From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 8 Aug 2013 18:25:18 +0200
Subject: [PATCH 0/2] Support for another NSA310
In-Reply-To: <5203C5A4.8000906@harsszegi.com>
References: <1374079910-24345-1-git-send-email-andrew@lunn.ch>
 <20130808135338.GF29815@lunn.ch> <5203C5A4.8000906@harsszegi.com>
Message-ID: <20130808162518.GK29815@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 06:21:56PM +0200, Tibor Harsszegi wrote:
> >On Wed, Jul 17, 2013 at 06:51:48PM +0200, Andrew Lunn wrote:
> >>There are apparently three different designs of the ZyXEL NSA310 NAS
> >>box. This patchset adds support for a second one, refactoring the
> >>common DTS parts into a shared DTSI file.
> >>
> >>What is not clear is naming. There is no obvious marketing name
> >>difference, hardware version label, etc. So for the same of argument,
> >>this new device uses the name NSA310a in DTS.
> >>
> >>The second patch adds to the kirkwood_defconfig drivers not already in
> >>the default configuration, plus some additional drivers used by other
> >>kirkwood devices. The aim is to improve build test coverage.
> >I've rebased these patches onto 3.11-rc4, which contains Thomas's PCI
> >fix, so that the Ethernet should work again. There are no changes to
> >my patches. It would be nice if people could test on there hardware
> >and send some tested-by:

> Hello, can confirm the nsa310a works fine (sytem boots, LEDs are
> working, eth0
> is up and running).

Hi Tibor

thanks for testing. Is it O.K. if i add a Tested-By: tag with your
name. See:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n423

Thanks
	Andrew
