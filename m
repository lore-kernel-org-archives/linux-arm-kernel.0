From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jul 2015 14:01:52 +0100
Subject: [PATCH] arm64: Split out platform options to separate Kconfig
In-Reply-To: <1436958621-23524-1-git-send-email-olof@lixom.net>
References: <1436958621-23524-1-git-send-email-olof@lixom.net>
Message-ID: <20150715130152.GG1005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Jul 15, 2015 at 12:10:21PM +0100, Olof Johansson wrote:
> Let's move out the platform Kconfig entries to a separate file, since these
> changes usually get moved through arm-soc instead of the arm64 arch tree, and
> this will lead to fewer conflicts
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Will, Catalin, I'll merge this through arm-soc if I get your acks. Thanks!

Fine by me:

  Acked-by: Will Deacon <will.deacon@arm.com>

The only problem I can think of is how we resolve defconfig conflicts
between you adding a new platform and us adding a new feature, since
resolving those usually happens by regenerating the defconfig anyway.

Maybe we just wait until -rc1 before adding new platforms to defconfig?

Will
