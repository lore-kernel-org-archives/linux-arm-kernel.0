From: W.Vanhauwaert@TELEVIC.com (Vanhauwaert Wouter)
Date: Wed, 14 Jun 2017 13:43:58 +0000
Subject: FEC data corruption?
Message-ID: <VI1PR0701MB27524436487BAFAF14AC92C5F8C30@VI1PR0701MB2752.eurprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
I'm trying to do a long-term network test on 2 platforms.
One is based on imx6q, the other on imx6ul.
imx6q is using linux-fslc, imx6ul is using linux-imx For that, I enabled the busybox inetd service with the echo protocol enabled. I'm flooding the device with echo requests of 12kiB (0x3000B) Most of the time that goes well, but at certain points, the data returned by the platform is corrupted. After some research, it looks like the data returned is copied from memory address 0 instead of the correct data address. Any idea what can cause this?
Here you'll find a screenshot of wireshark showing this behavior: https://snag.gy/S7cBRl.jpg

Thanks
