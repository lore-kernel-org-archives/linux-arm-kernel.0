From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Jan 2013 14:12:25 +0200
Subject: [PATCH v2 0/3] at91: PMECC: enable PMECC in dt for
 at91sam9x5ek, at91sam9n12ek
In-Reply-To: <1358393072-14794-1-git-send-email-josh.wu@atmel.com>
References: <1358393072-14794-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1358424745.2731.238.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-01-17 at 11:24 +0800, Josh Wu wrote:
> Those patches will enable PMECC in dt parameters for at91sam9x5ek, at91sam9n12ek.
> The driver will check minimum required ecc on ONFI parameter from NAND flash. 
> If pmecc-cap in dts doesn't meet the requirement then driver reports a error.
> 
> v2: rebase to v3.8-rc3. And wrapped the commit message.

Please, whenever you know your patch-set depends on something which is
not yet in Linuse's tree, _always_ explicitly say about this.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/92f99152/attachment.sig>
