From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 04 Jul 2012 19:50:47 -0700
Subject: [PATCH] remoteproc: adopt the driver core's alloc/add/del/put
 naming
In-Reply-To: <1341409019-32166-1-git-send-email-ohad@wizery.com>
References: <1341409019-32166-1-git-send-email-ohad@wizery.com>
Message-ID: <4FF50107.8030406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/4/2012 6:36 AM, Ohad Ben-Cohen wrote:
> To make remoteproc's API more intuitive for developers, we adopt
> the driver core's naming, i.e. alloc -> add -> del -> put. We'll also
> add register/unregister when their first user shows up.
>
> Otherwise - there's no functional change here.
>
> Suggested by Russell King <linux@arm.linux.org.uk>.
>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Cc: Sjur Br?ndeland <sjur.brandeland@stericsson.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
