From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 15 Feb 2017 12:44:27 -0600
Subject: [PATCH v3] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
In-Reply-To: <20170215180159.11359-1-cov@codeaurora.org>
References: <20170215180159.11359-1-cov@codeaurora.org>
Message-ID: <f26b71df-9a5b-ced7-5364-699f5df8891a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2017 12:01 PM, Christopher Covington wrote:
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Timur Tabi <timur@codeaurora.org>

It would great if we could get this into 4.11.  As crazy it sounds, it is the 
only critical patch in 4.11 that we need for our platform.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
