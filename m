From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 26 Jan 2013 18:38:59 +0100
Subject: [PATCH 2/2] ARM: Kirkwood: topkick: Enable i2c bus.
In-Reply-To: <1359219326-5927-2-git-send-email-andrew@lunn.ch>
References: <f6d483f3fb83826bce16f956afa013f0bcf11f52.1359146831.git.jason@lakedaemon.net>
 <1359219326-5927-1-git-send-email-andrew@lunn.ch>
 <1359219326-5927-2-git-send-email-andrew@lunn.ch>
Message-ID: <510414B3.6000207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2013 05:55 PM, Andrew Lunn wrote:
> Add a DT node for I2C and pinctrl hog for the pins. There appears to
> be an i2c bus on topkick with a device on it:
>
> 60: -- -- -- -- 64 -- -- -- -- -- -- -- -- -- -- --

Andrew,

this could be a Nuvoton NCT3012S ACPI PMIC. It is located right next to
Wifi/BT. There is i2c address should be 6c but officially it
only supports 100kHz bus frequency. Can you post i2cdetect and
i2cdump with 100kHz?

Sebastian

[1] http://www.catagle.com/29-11/NCT3012S.htm
