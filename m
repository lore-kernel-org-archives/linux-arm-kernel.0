From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 15:14:54 +0100
Subject: [GIT PULL] CSR SiRFSOC DT for 3.19
In-Reply-To: <CAGsJ_4yC8bStnYx3ramD=OXA03oihUEwCgcfqsStfWx2rasMqQ@mail.gmail.com>
References: <CAGsJ_4yC8bStnYx3ramD=OXA03oihUEwCgcfqsStfWx2rasMqQ@mail.gmail.com>
Message-ID: <201411281514.54841.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014, Barry Song wrote:
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   gitolite.kernel.org:/pub/scm/linux/kernel/git/baohua/linux.git
> tags/sirf-dts-for-3.19
> 
> for you to fetch changes up to 294a212faa5bf7cb48fabccec5ee13e836e29ecb:

The URL did not work for me, I had to replace it with

git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux

and I checked that the commit ID is the same. I think you need to
configure your git tree to have a separate url and pushurl for
your remote, so your pull requests are derived from a publically
accessible url.

>   ARM: dts: atlas6: add resets property for SPI nodes (2014-11-25
> 18:46:43 +0800)
> 
> ----------------------------------------------------------------
> change pinmux pingroup and add some lost node/prop
> 
> 1. add resets properity for some nodes;
> 2. change pinctrl groups for audio
> 3. add PMU node

Pulled into next/dt, thanks!

	Arnd
