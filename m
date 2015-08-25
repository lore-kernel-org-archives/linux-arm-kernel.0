From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Aug 2015 10:17:38 -0700
Subject: [GIT PULL 2/2] Rockchip soc fix for 4.3
In-Reply-To: <9416843.VhjrryKIms@phil>
References: <1879932.6Bpqy7C2KO@phil>
	<9416843.VhjrryKIms@phil>
Message-ID: <CAOesGMiVy5F-EJFCyj5LLKCGUWNZGenrK6AhbjubfBADXMxE_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 2:30 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Arnd, Kevin, Olof,
>
> Fabio did find an error in what is returned as error codes in the init of
> the suspend code. Nobody complained about this actually breaking stuff
> but it would be nice to have this fixed nevertheless, so please pull.
>
>
> Thanks
> Heiko
>
>
> The following changes since commit 9bb91ae970dd004393a3d7d09bdcc30dfe2f8693:
>
>   ARM: rockchip: enable PMU_GPIOINT_WAKEUP_EN when entering shallow suspend (2015-08-06 13:05:14 +0200)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.3-rockchip32-soc3
>
> for you to fetch changes up to 2a03c025fdea25a491c359b31d8a8c8d452b06d0:
>
>   ARM: rockchip: pm: Fix PTR_ERR() argument (2015-08-24 12:39:14 +0200)

Merged, thanks.


-Olof
