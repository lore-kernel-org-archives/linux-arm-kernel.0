From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 29 Aug 2010 15:08:42 +0300
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
Message-ID: <1283083722.2131.34.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-10 at 13:34 +0200, John Ogness wrote:
> This patch sets the NFC registers for spare size and pages per block.
> 
> This patch is against the latest patches from Sascha Hauer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/mtd/nand/mxc_nand.c |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

I'm not picking your patches and assume they'll be sent by Sascha.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
