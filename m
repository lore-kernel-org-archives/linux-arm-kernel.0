From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 22 Nov 2017 10:49:50 +0000
Subject: [PATCH v3] staging: fsl-mc: use 32bits to support 64K size
 mc-portals
In-Reply-To: <1511336923-610-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1511336923-610-1-git-send-email-Bharat.Bhushan@nxp.com>
Message-ID: <5A155642.70809@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/22/2017 09:48 AM, Bharat Bhushan wrote:
> As per APIs each mc-portal is of 64K size while currently
> 16bits (type u16) is used to store size of mc-portal.
> In these cases upper bit of portal size gets truncated.
>
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---

Ok, so just to clarify this fixes the case where size is equal (or maybe 
larger in the future) to 0x10000.

Acked-By: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
