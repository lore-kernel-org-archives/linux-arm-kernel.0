From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2017 23:56:42 +0000
Subject: [PATCH] arm: module: add support for R_ARM_REL32 relocations
In-Reply-To: <1484863892-5818-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484863892-5818-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170119235642.GK27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 10:11:32PM +0000, Ard Biesheuvel wrote:
> Add support for R_ARM_REL32 relocations in the module loader,
> which will be used by the modversions code when (if) it switches
> to using relative references to refer to CRC values.

Thanks, please keep this patch handy for when (if) that does happen.
I won't apply this until it is actually needed - no point adding stuff
that never gets used (and therefore doesn't get tested.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
