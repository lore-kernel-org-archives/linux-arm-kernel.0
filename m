From: davidb@codeaurora.org (David Brown)
Date: Mon, 11 Jun 2012 13:37:48 -0700
Subject: [PATCH] ARM: two possible fixes for the KALLSYMS build problem
In-Reply-To: <1338567721-19514-1-git-send-email-davidb@codeaurora.org>
References: <1338567721-19514-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20120611203748.GA16967@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2012 at 09:21:59AM -0700, David Brown wrote:

> David Brown (1):
>   ARM: Prevent KALLSYM size mismatch on ARM.
> 
>  arch/arm/kernel/vmlinux.lds.S |    3 +++
>  1 file changed, 3 insertions(+)

Just wondering if anyone has had a chance to look at either of these,
or try them.  I haven't seen any KALLSYMS mismatch build errors with
either of these patches applied.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
