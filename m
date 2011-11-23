From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Nov 2011 21:15:13 +0000
Subject: [GIT PULL v2] pxa: fixes for v3.2-rc1
In-Reply-To: <CAMPhdO8cJxSnTzNEeu+D-cOxQr7_OU6oOA55AhQbO6vHe0f11A@mail.gmail.com>
References: <CAMPhdO8cJxSnTzNEeu+D-cOxQr7_OU6oOA55AhQbO6vHe0f11A@mail.gmail.com>
Message-ID: <201111232115.13430.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 November 2011, Eric Miao wrote:
> The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:
> 
>   Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)
> 
> are available in the git repository at:
>   git://github.com/ycmiao/pxa-linux.git fix
> 
> Eric Miao (1):
>       ARM: pxa168/gplugd: add the correct SSP device
> 
> Haojian Zhuang (2):
>       ARM: pxa: fix inconsistent CONFIG_USB_PXA27X
>       ARM: mmp: fix build error on gpio
> 

Looks all good, sorry for the delay on my side.

Should the "ARM: pxa168/gplugd: add the correct SSP device" have a
"Cc: stable at kernel.org" tag? It's not clear from the patch.
If it applies to older kernels as well, please make sure that Greg
picks it up once Linus merges it, and next time mark stable bug
fixes right away, or mention in the pull request that it's only
regressions.

	Arnd
