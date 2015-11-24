From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 24 Nov 2015 10:08:28 -0800
Subject: [PATCH v5 3/5] watchdog: ts4800: add driver for TS-4800 watchdog
In-Reply-To: <1448388053-30661-4-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448388053-30661-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448388053-30661-4-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <20151124180828.GA11719@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 01:00:51PM -0500, Damien Riegel wrote:
> This watchdog is instantiated in a FPGA that is memory mapped. It is
> made of only one register, called the feed register. Writing to this
> register will re-arm the watchdog for a given time (and enable it if it
> was disable). It can be disabled by writing a special value into it.
> 
> It is part of a syscon block, and the watchdog register offset in this
> block varies from board to board. This offset is passed in the syscon
> property after the phandle to the syscon node.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
