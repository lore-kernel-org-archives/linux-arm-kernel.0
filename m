From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 2 Jul 2018 08:02:11 +0200
Subject: [PATCH v1] ARM: imx: add imx7d-m4
In-Reply-To: <20180617064638.GJ16091@dragon>
References: <20180405115134.8036-1-o.rempel@pengutronix.de>
 <20180617064638.GJ16091@dragon>
Message-ID: <7833c9ee-68ce-a008-46a8-4868e2f20b89@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17.06.2018 08:46, Shawn Guo wrote:
> On Thu, Apr 05, 2018 at 01:51:34PM +0200, Oleksij Rempel wrote:
>> Provide basic support for Cortex-M4 located on NXP iMX7D.
>> This code was tested in combination with imx-rproc driver
>> which will upload with specially formatted ELF image containing
>> kernel, device and CPIO rootfs.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Can we make the patch subject a bit more complete, at least like
> "ARM: imx: add imx7d-m4 support" or something?

ok.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/bebf1ca0/attachment.sig>
