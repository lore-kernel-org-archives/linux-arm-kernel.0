From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 3 May 2016 10:07:48 -0500
Subject: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
In-Reply-To: <20160503143856.GE13045@dhcppc6.redhat.com>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net> <20160503143856.GE13045@dhcppc6.redhat.com>
Message-ID: <5728BEC4.6050603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush Anand wrote:
> In fact after supporting max_hw_heartbeat_ms, there should be no change for
> action=0 functionally. However, we would still need some changes for action=1.

IMHO, action=1 is more of a debugging option, and not something that 
would be used normally.  I would need to see some evidence that real 
users want to have action=1 and a longer timeout.

I've never been a fan of the action=1 option, and I'm certainly not keen 
any patches that make action=1 more complicated than it already is.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
