From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 17:21:13 +0200
Subject: [GIT PULL] arm64: Juno DT updates
In-Reply-To: <20150522112140.GU2175@e106497-lin.cambridge.arm.com>
References: <20150522112140.GU2175@e106497-lin.cambridge.arm.com>
Message-ID: <2567909.I1O9qVuofr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 May 2015 12:21:40 Liviu Dudau wrote:
> The following changes since commit c0655fe9b0901a968800f56687be3c62b4cce5d2:
> 
>   Merge tag 'usb-4.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2015-05-16 21:15:59 -0700)
> 


Please rebase onto 4.1-rc1 and send a new pull request for this.

We can't take branches that are based on a random commit from torvalds,
and we prefer the base to be no newer than what our other branches
are based on (normally -rc1 or -rc2), as that causes trouble for us
when we generate the upstream pull requests.

	Arnd
