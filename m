From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Jun 2017 11:12:21 -0300
Subject: FEC data corruption?
In-Reply-To: <VI1PR0701MB27524436487BAFAF14AC92C5F8C30@VI1PR0701MB2752.eurprd07.prod.outlook.com>
References: <VI1PR0701MB27524436487BAFAF14AC92C5F8C30@VI1PR0701MB2752.eurprd07.prod.outlook.com>
Message-ID: <CAOMZO5AVNBCTSABjXhk-WJCXYhONex59swtwcAHQfoc8H45G2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 10:43 AM, Vanhauwaert Wouter
<W.Vanhauwaert@televic.com> wrote:
> Hello
> I'm trying to do a long-term network test on 2 platforms.
> One is based on imx6q, the other on imx6ul.
> imx6q is using linux-fslc, imx6ul is using linux-imx For that, I enabled the busybox inetd service with the echo protocol enabled. I'm flooding the device with echo requests of 12kiB (0x3000B) Most of the time that goes well, but at certain points, the data returned by the platform is corrupted. After some research, it looks like the data returned is copied from memory address 0 instead of the correct data address. Any idea what can cause this?
> Here you'll find a screenshot of wireshark showing this behavior: https://snag.gy/S7cBRl.jpg

Does the problem happen if you run kernel 4.11.5 or 4.12-rc?

If it does, then please also include the netdev mailing list.

Regards,

Fabio Estevam
