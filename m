From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Jan 2013 23:08:48 -0800
Subject: [GIT PULL] CSR SiRFmarco SoC infrastructures for 3.9
In-Reply-To: <CAGsJ_4z-7z8=3xQwU6iEsqHEcVrRWK+Fm7eoBEbjC-EAewGypA@mail.gmail.com>
References: <CAGsJ_4z-7z8=3xQwU6iEsqHEcVrRWK+Fm7eoBEbjC-EAewGypA@mail.gmail.com>
Message-ID: <20130128070848.GG25723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 11:21:02AM +0800, Barry Song wrote:
> Hi Olof, Arnd,
> 
> pls pull the following changes for CSR SiRFmarco SoC. it has been
> rebased againest arm-soc timer/cleanup tree.
> 
> since commit 90cf214d6a549bf482e3c5751ee256cc885b96ea:
> 
>   ARM: at91: fix board-rm9200-dt after sys_timer conversion
> (2013-01-14 10:14:04 -0800)
> 
> are available in the git repository at:
>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git
> marco-timer-cleanup-rebase

Pulled in as prima2/marco, included in next/soc. Thanks!

I noticed that there is no defconfig for any mach-prima2 platforms. Feel
free to submit one so we get build coverage of the platform.


-Olof
