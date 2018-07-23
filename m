From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 23 Jul 2018 20:07:22 +0200
Subject: [PATCH] i2c: davinci: Avoid zero value of CLKH
In-Reply-To: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
Message-ID: <20180723180722.7b46aw56oqxrwxwj@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 05:20:17PM +0200, Alexander Sverdlin wrote:
> If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
> and stretch the clock in this case.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Applied to for-current, thanks!

I did not add stable because Alexander told me this is very likely not
to be observed on HW out there. But TI people are investigating more.
I suggest they resend this patch to stable if they see fit. D'accord
everyone?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180723/8ea58ced/attachment.sig>
