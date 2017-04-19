From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Apr 2017 14:17:43 +0100
Subject: LDM/STM alignment fixups on arm64
In-Reply-To: <58F75D02.1030104@codeaurora.org>
References: <58F704D6.6000301@codeaurora.org>
 <20170419095830.GK17774@n2100.armlinux.org.uk>
 <58F75D02.1030104@codeaurora.org>
Message-ID: <20170419131743.GL17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 06:20:10PM +0530, Srinivas Ramana wrote:
> I don't have any application with me right now. But i just tried passing an
> intentional misaligned address in a test program. When i say intentional,
> please note this code is buggy and should be fixed.

Until there's reports of some application that regresses, there is
nothing to fix.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
