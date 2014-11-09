From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Nov 2014 16:25:01 -0800
Subject: [GIT PULL] Broadcom Cygnus SoC Device Tree changes
In-Reply-To: <1414698612-26216-2-git-send-email-f.fainelli@gmail.com>
References: <1414698612-26216-1-git-send-email-f.fainelli@gmail.com>
 <1414698612-26216-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <20141109002501.GC11947@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Thu, Oct 30, 2014 at 12:50:10PM -0700, Florian Fainelli wrote:
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/brcm/linux.git tags/arm-soc/for-3.18/cygnus-dts-v9
> 
> for you to fetch changes up to 8872fc22c2670cde338ab92be4a8e9ebad8e53e6:
> 
>   ARM: dts: Enable Broadcom Cygnus SoC (2014-10-30 11:05:55 -0700)
> 
> ----------------------------------------------------------------
> This patchset contains initial support for Broadcom's Cygnus SoC based on our
> iProc architecture. Initial support is minimal and includes just the mach
> platform code, clock driver, and a basic device tree configuration. Peripheral
> drivers will be submitted soon, as will device tree configurations for other
> Cygnus board variants.
> 
> These are the Device Tree changes
> 
> ----------------------------------------------------------------
> Jonathan Richardson (1):
>       dt-bindings: Document Broadcom Cygnus SoC and clocks
> 
> Scott Branden (1):
>       ARM: dts: Enable Broadcom Cygnus SoC

I just posted a set of comments on this original patch that I noticed
when reviewing it while merging. Please send a fresh pull request when
they're addressed.

Also, about your tag texts: There's no need to have the first paragraph
boiler on all of them, I'd rather appreciate a sentence or two about
what the DTS'es are in this case (i.e. one dtsi for the family and three
different boards based on it), etc. You'll get a hang of it over time. :)


-Olof
