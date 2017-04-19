From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Apr 2017 10:58:30 +0100
Subject: LDM/STM alignment fixups on arm64
In-Reply-To: <58F704D6.6000301@codeaurora.org>
References: <58F704D6.6000301@codeaurora.org>
Message-ID: <20170419095830.GK17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 12:03:58PM +0530, Srinivas Ramana wrote:
> Hi,
> 
> While understanding how the alignment are handled on arm and arm64, we came
> across the fixups for LDM/LDRD/STM on arm where as these fixups are not
> present on arm64.
> 
> There may be some specific reason why these fixups are not ported to arm64.
> Can you please help us understand this?
> 
> With this difference in how kernel handles 32-bit apps on arm and arm64,
> there can be apps which are working without abort on arm, but fail on arm64
> (SIGBUS). We have tried to get some history on web, but not successful.
> 
> If this is indeed missing on arm64, do you see any issue if its ported (does
> it fail any guidance)?

Do you have an application that fails because of this?  Your email makes
it sound very theoretical.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
