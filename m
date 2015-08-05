From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Aug 2015 10:40:00 +0200
Subject: [GIT PULL] at91: dt for 4.3 #1
In-Reply-To: <1438275657-10769-1-git-send-email-nicolas.ferre@atmel.com>
References: <1438275657-10769-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150805084000.GB6390@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 07:00:57PM +0200, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is the first batch of DT changes for 4.3. The main part of it is the
> addition of a new SoC in the sama5 family: the sama5d2. Here is its product
> .dtsi and the associated sama5d2 Xplained board description.
> I'll send the little C code part of it in another pull-request or as a single
> separated patch as I don't have other material on the "at91-4.3-soc" branch for
> now...
> 
> Thanks, best regards,
> 
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
> 
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt
> 
> for you to fetch changes up to 22b5a0f7bc07ac4b4e4aab9a7f8cf2521819c1c4:
> 
>   ARM: at91/dt: add minimal sama5d2 Xplained board (2015-07-30 18:44:44 +0200)

Merged, thanks.

Also, congrats on getting basic mainline support merged by the time
the part is actually announced and available. I wish more vendors would
follow your lead.


-Olof
