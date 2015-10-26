From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Oct 2015 14:27:07 +0900
Subject: [GIT PULL 2/2] Broadcom drivers changes for 4.4 (try 2)
In-Reply-To: <1445718981-13552-1-git-send-email-f.fainelli@gmail.com>
References: <1445718981-13552-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20151026052707.GA4216@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 24, 2015 at 01:36:20PM -0700, Florian Fainelli wrote:
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/Broadcom/stblinux tags/arm/soc/for-4.4/rpi-drivers
> 
> for you to fetch changes up to 16134b3bc317c571e953d18196acf0a92afda5ff:
> 
>   ARM: bcm2835: add mutual inclusion protection (2015-10-24 13:15:58 -0700)

Merged, but I noticed that the entries in drivers/firmware/Makefile and
drivers/firmware/Kconfig weren't added alphabetically (I know, Kconfig has an
inversion between D and E already).

When it's just appended, there's easily add-add conflicts, which is why
I noticed.

I fixed up when merging, but please keep an eye on new additions in
the future.


-Olof
