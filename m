From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 18 Jul 2012 13:40:53 +0300
Subject: [PATCH 1/5] ubi: introduce ubi->bad_peb_limit
In-Reply-To: <1341389164-24409-2-git-send-email-shmulik.ladkani@gmail.com>
References: <1341389164-24409-1-git-send-email-shmulik.ladkani@gmail.com>
 <1341389164-24409-2-git-send-email-shmulik.ladkani@gmail.com>
Message-ID: <1342608053.7530.11.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-04 at 11:06 +0300, Shmulik Ladkani wrote:
> Introduce 'ubi->bad_peb_limit', which specifies an upper limit of PEBs
> ubi expects to go bad.
> Currently, it is initialized to a fixed percentage of total PEBs in the
> ubi device (configurable via CONFIG_MTD_UBI_BEB_LIMIT).
> 
> The 'bad_peb_limit' is intended to be used for calculating the amount of
> PEBs ubi needs to reserve for bad eraseblock handling.
> 
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> ---
>  arch/arm/configs/sam9_l9260_defconfig |    1 +

I've also amended the Kconfig text a tiny bit and dropped the defconfig
changes - let's have them separately as a single patch at the end of the
series.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120718/544983b4/attachment.sig>
