From: balbi@ti.com (Felipe Balbi)
Date: Tue, 15 Jul 2014 13:02:04 -0500
Subject: [RFC/PATCH 5/5] ARM: dts: am437x-sk-evm: add vpfe support and
 ov2659 sensor
In-Reply-To: <1405447012-5340-6-git-send-email-balbi@ti.com>
References: <1405447012-5340-1-git-send-email-balbi@ti.com>
 <1405447012-5340-6-git-send-email-balbi@ti.com>
Message-ID: <20140715180204.GB5098@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 15, 2014 at 12:56:52PM -0500, Felipe Balbi wrote:
> From: Darren Etheridge <detheridge@ti.com>
> 
> Adding necessary dts nodes to enable vpfe and ov2659 sensor on the correct i2c

clearly this doesn't add ov2659 sensor support because we can't release
the driver for it. I'll fix the patch subject and commit log locally.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/22f2daff/attachment.sig>
