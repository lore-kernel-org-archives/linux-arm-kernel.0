From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Mar 2014 17:47:04 +0000
Subject: [PATCH] ARM: mach-ux500|nomadik|u300: Align to common DT
 bindings for mmci
In-Reply-To: <1394713963-18300-1-git-send-email-ulf.hansson@linaro.org>
References: <1394713963-18300-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140313174703.GO21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 01:32:43PM +0100, Ulf Hansson wrote:
> As the first step in preparing the mmci driver for converting to the
> mmc_of_parse API, let's align to the common names of DT bindings for
> the mmc/sd highspeed modes.

NAK.  These bindings have been documented as being there since March
14th 2012, and therefore need to be supported for ever by the driver.
You can _augment_ the bindings with the generic ones, and change the
DT files, but you can't remove the parsing of the old property names.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
