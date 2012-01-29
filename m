From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 30 Jan 2012 09:33:22 +1100
Subject: mfd: mc13xxx adc fixes and enhancements
Message-ID: <1327876408-22528-1-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provides some small fixes to the mc13xxx adc conversion funtion to
make it more robust. Readout of single channel conversions is fixed so that the
read out order corresponds to the sampling order (Critical for dedicated 
battery reading).

A new conversion function is introduced which allows the caller to enable the
dedicated readings and other adc functionality by providing a mask/ value pair
for the adc0,1 registers.

These patches apply onto my 'add I2C support' series [1].
(I think only the first patch is required)

Cheers,
Marc

[1] http://lists.arm.linux.org.uk/lurker/message/20120119.010131.616dd8a6.en.html
