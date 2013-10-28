From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Oct 2013 21:21:07 -0700
Subject: [GIT PULL] ux500 devicetree patches, take 3
In-Reply-To: <CACRpkdYyazH9KevkA=qTho3okdKnKWcq_uMwRroa6=svacfJAQ@mail.gmail.com>
References: <CACRpkdYyazH9KevkA=qTho3okdKnKWcq_uMwRroa6=svacfJAQ@mail.gmail.com>
Message-ID: <20131028042107.GF22890@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 09:23:45PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this is yet another pull request for ux500 device tree stuff. It should
> go on top of the second pull request, I tested to pull it on top of
> ux500/dt2 in the ARM SoC tree and it worked just fine.
> 
> These are fixes and additions found during testing of the switch to
> full device tree on ux500. The clock fixes will go into the -rc:s if
> you don't take this in as a whole.
> 
> There is one oneline patch to the clock driver that I have not had
> an ACK from Mike on, but Lee checked it and I certainly don't
> think Mike has anything against it. The last patch adds the SSP
> and SPI devices that were strangely absent from the platform
> after the conversion.
> 
> So: please pull this into ARM SoC as ux500/dt3 or something.

Thanks, pulled into next/dt.


-Olof
