From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 23:51:56 +0200
Subject: [GIT PULL #2] ARM: BCM: Broadcom BCM63138 support
In-Reply-To: <1410977394-27987-1-git-send-email-f.fainelli@gmail.com>
References: <1410977394-27987-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <201409252351.56707.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 September 2014, Florian Fainelli wrote:
> Changes in v2:
> - rebased against v3.17-rc1
> - added Arnd's Acked-by
> - added a proper tag to pull from
> 

Pulled into next/soc.

Please always put a changeset text in your tag. I've taken this text
out of the previous review submission:

    ARM: BCM: Broadcom BCM63138 support
    
    This patchset adds very minimal support for the BCM63138 SoC which is
    a xDSL SoC using a dual Cortex A9 CPU complex.

but it helps to be a little more verbose than that.

Thanks,

	Arnd
