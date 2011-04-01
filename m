From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 01 Apr 2011 01:44:08 -0700
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <BANLkTimtAcPLmcFKoHkCtWcJipy+rSSP+A@mail.gmail.com>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
	<BANLkTimtAcPLmcFKoHkCtWcJipy+rSSP+A@mail.gmail.com>
Message-ID: <4D959058.7010606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/31/2011 6:47 PM, Simon Glass wrote:
> You might try the generic bug patch and see if it also fixes this
> problem - Simon

It probably won't because presumably Omar has CONFIG_BUG=n otherwise
Omar would have sent a patch against __bug() in arch/arm/kernel/traps.c

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
