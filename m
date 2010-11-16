From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 16 Nov 2010 12:30:57 -0800
Subject: [PATCH 1/3] msm: sirc: warning fix
In-Reply-To: <1289598593-8974-1-git-send-email-davidb@codeaurora.org>
References: <1289598593-8974-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1289939457.9950.1.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-12 at 13:49 -0800, David Brown wrote:
> Eliminate some unreferenced variables.
> 
> arch/arm/mach-msm/sirc.c:43: warning: 'save_type' defined but not used
> arch/arm/mach-msm/sirc.c:44: warning: 'save_polarity' defined but not used


I accepted these three , but I altered the commit test to change the
shortlog so it's a little more descriptive. Changes below,

msm: sirc: remove some unused variables
msm: smd: ifdef adjustment to remove unused variables
msm: make constant unsigned long to correct format warning


Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
