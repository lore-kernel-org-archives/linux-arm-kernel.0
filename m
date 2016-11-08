From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2016 14:51:18 +0000
Subject: [PATCH 0/8] firmware: arm_scpi: add support for legacy SCPI
 protocol
In-Reply-To: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20161108145118.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 10:52:03PM -0600, Sudeep Holla wrote:
> This is minor rework of the series[1] from Neil Armstrong's to support
> legacy SCPI protocol to make DT bindings more generic and move out all
> the platform specific bindings out of the generic binding document.

Is this what would be in my HBI0282B Juno?

(Note: I only have the original firmware on the board, as the Linaro
firmware drops are completely broken for it.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
