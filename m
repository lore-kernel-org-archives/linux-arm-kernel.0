From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 22:22:14 +0200
Subject: [GIT PULLv2] at91: dt for 4.4 #2
In-Reply-To: <20151021205938.GA18600@piout.net>
References: <20151021205938.GA18600@piout.net>
Message-ID: <6283901.cB5kt79X9G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 October 2015 22:59:38 Alexandre Belloni wrote:
> 
> The following changes since commit a9b672a636a599cc052afcb6837e3177dc53c143:
> 
>   ARM: at91/dt: sama5d2 Xplained: add device pin muxing (2015-09-23 16:26:47 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-dt2
> 
> for you to fetch changes up to 512fc048e4fdc39f43e78af7e2fed5047d651979:
> 
>   ARM: at91/dt: sama5d2: add missing devices (2015-10-19 21:22:21 +0200)
> 
> ----------------------------------------------------------------
> Second batch of DT changes for 4.4:
> - some DT fixes: pullups, disabled property
> - the PMC is now a syscon
> - great improvement of sama5d2 support
> 

Pulled into next/dt, thanks!

	Arnd
