From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 19 Jan 2012 11:51:12 +0000
Subject: [PATCH 1/2] ARM: OMAP3+: dpll: Configure autoidle mode only if
 its supported
In-Reply-To: <1326973598-8209-1-git-send-email-vaibhav.bedia@ti.com>
References: <1326973598-8209-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433178C451@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 17:16:38, Bedia, Vaibhav wrote:
> The current DPLL code enables and disables autoidle features
> without checking whether the autoidle register is available.
> Fix this by putting a check for the existence of the autoidle
> register in the DPLL data.
> 
> With such a check in place, for DPLLs which do not support this
> feature, simply skipping the autoidle_reg entry in the DPLL data
> is sufficient.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

There's no PATCH 2/2 here. Sorry about that. If needed, I can resend
this one.
