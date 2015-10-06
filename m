From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 6 Oct 2015 18:20:50 +0200
Subject: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
In-Reply-To: <CAPv3WKebE9SHd25mDbn+y4f0awseo_KXA9-aFgUNHTty4KxGFQ@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-7-git-send-email-mw@semihalf.com>
 <20151006033131.GA24230@lunn.ch>
 <CAPv3WKeUQ6rsYWJ3C+aX8eHTAdS4SmQ3oCjA9feFf+d-n1RvhA@mail.gmail.com>
 <8737xo9gvx.fsf@free-electrons.com>
 <CAPv3WKebE9SHd25mDbn+y4f0awseo_KXA9-aFgUNHTty4KxGFQ@mail.gmail.com>
Message-ID: <20151006162050.GA3557@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> My first feeling is that creating brand new dts just for sdhci
> detection (afaik there are no other bigger modifications of the PCB)
> is not the best idea. However maybe changing armada-388-gp.dts to dtsi
> and then add two single-entries' dts files on top is an option?

Yes, that is the correct way to do this, if we decide to have two DT
blobs for different hardware versions.

      Andrew
