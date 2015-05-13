From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 16:18:18 +0200
Subject: [GIT PULL] ARM: rockchip: fixup duplicate suspend fix
In-Reply-To: <4262241.MKs4C65R3h@phil>
References: <4262241.MKs4C65R3h@phil>
Message-ID: <41527875.jtmyBXaoXQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 16:17:24 Heiko Stuebner wrote:
> Hi Arnd, Olof,
> 
> it looks like I got confused when going through the patches fixing suspend
> issues and from the two of them only one is actually necessary, as both fix
> the same symptom. Thankfully Chris pointed out this issue and also
> confirmed which patch should actually be kept. So this pull-req reverts the
> other (obsolete) one.
> 
> Sorry for the mess-up.
> 

Pulled into the fixes branch, thanks!

	Arnd
