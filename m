From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Oct 2013 12:21:47 +0100
Subject: [PATCH RFC 0/2] Initial Solid Run Cubox-i carrier-1 support
Message-ID: <20131005112147.GX12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is where I am at the moment with the SolidRun Cubox-i Carrier-1
board support with v3.12-rc3.  What's included and tested here is:

- Consumer IR
- SD card slot
- AR8035 ethernet phy
- HDMI DDC I2C
- USB

What isn't included:
- RTC (commented out) since the chip is not fitted to developer boards yet
- HDMI output
- SPDIF output
- Audio output (codec not fitted)
- Wireless (not fitted)

I'm sending this out as an RFC as it's not at the point for merging, but
those with the developer board should find it useful to get their boards
up and running with recent kernels.
