From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 12 Jan 2010 01:38:14 +0000
Subject: S3C/S5P device updates - request for comments
Message-ID: <20100112013814.GA18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As some of you may know I am currently working on updating the device
code on the Samsung SoC range to avoid the ugly hacks to provide things
like the base address.

I am considering changing the functions that register the platform data
to also register the associated device, since I have found nowhere where
a board sets the platform data to then not go on and register the device
associated with it.

IE, calling s3c_i2c0_set_platdata() would also register s3c_device_i2c0
with the platform system.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
