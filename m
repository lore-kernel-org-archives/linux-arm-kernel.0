From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 Jul 2012 11:11:47 -0700
Subject: [PATCH] remoteproc: remove the get_by_name/put API
In-Reply-To: <1341259857-17382-1-git-send-email-ohad@wizery.com>
References: <1341259857-17382-1-git-send-email-ohad@wizery.com>
Message-ID: <4FF335E3.5040509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/12 13:10, Ohad Ben-Cohen wrote:
> Remove rproc_get_by_name() and rproc_put(), and the associated
> remoteproc infrastructure that supports it (i.e. klist and friends),
> because:
>
> 1. No one uses them
> 2. Using them is highly discouraged, and any potential user
>    will be deeply scrutinized and encouraged to move.
>
> If a user, that absolutely can't live with the direct boot/shutdown
> model, does show up one day, then bringing this functionality back
> is going to be trivial.
>
> At this point though, keeping this functionality around is way too
> much of a maintenance burden.
>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

> Cc: Sjur Br?ndeland <sjur.brandeland@stericsson.com>
> Cc: Loic Pallardy <loic.pallardy@stericsson.com>
> Cc: Ludovic BARRE <ludovic.barre@stericsson.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Cc: Suman Anna <s-anna@ti.com>
> Cc: Mark Grosen <mgrosen@ti.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
