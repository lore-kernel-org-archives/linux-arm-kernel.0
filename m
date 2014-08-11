From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Aug 2014 11:02:41 +0100
Subject: [PATCH 3/5] mmc: sdhci-pltfm: Do not use parent as the host's
 device
In-Reply-To: <1407748550.3680.10.camel@hornet>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-3-git-send-email-pawel.moll@arm.com>
 <1407515785.31897.28.camel@hornet>
 <CAPDyKFoLU6pnJFmKe7CB0q-hKfwv4uCPSr0cE4aoYMvfhjMteQ@mail.gmail.com>
 <1407748550.3680.10.camel@hornet>
Message-ID: <20140811100241.GB30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 10:15:50AM +0100, Pawel Moll wrote:
> On Mon, 2014-08-11 at 10:07 +0100, Ulf Hansson wrote:
> > Sorry for the delay. I suppose this make sense, but I really don't
> > know for sure.
> > 
> > I guess we need some testing in linux-next, to get some confidence.
> 
> Would you take it into -next then? Unless I'm completely wrong there
> should be no impact on any in-tree driver...

But not until 3.17-rc1 has been released.  linux-next should not receive
new material other than bug fixes while a merge window is open.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
