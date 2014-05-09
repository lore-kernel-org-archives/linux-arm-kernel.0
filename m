From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 9 May 2014 11:38:46 +0100
Subject: [RFC 13/47] mtd: nand: stm_nand_bch: provide Device Tree support
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACBC8F@DBDE04.ent.ti.com>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <1395735604-26706-14-git-send-email-lee.jones@linaro.org>
 <20980858CB6D3A4BAE95CA194937D5E73EAB5C83@DBDE04.ent.ti.com>
 <20140430125406.GN29462@lee--X1>
 <20980858CB6D3A4BAE95CA194937D5E73EACA3F0@DBDE04.ent.ti.com>
 <20140509100304.GR5767@lee--X1>
 <20980858CB6D3A4BAE95CA194937D5E73EACBC8F@DBDE04.ent.ti.com>
Message-ID: <20140509103846.GS5767@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >Ah, I see.  I will fixup, thanks for the explanation.
> >
> 
> Please wait, I'll review your [v2] series also, then you can further
> send all fixes together. I'm bit caught in other commitments for 3.16,
> so hopefully I'll be able to review your patches by next week.

I have already fixed up, but I won't resubmit until you have
reviewed.

FYI: I have made some changes since v2 including moving over to the
recently submitted core timing structure submitted by Boris Brezillon
and removal bitflip_threshold as an internal variable.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
