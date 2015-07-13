From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 13 Jul 2015 16:37:50 -0700
Subject: [PATCH v2] Input: pmic8xxx-pwrkey - Support shutdown
In-Reply-To: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org>
References: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150713233750.GA32767@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 13 Jul 16:30 PDT 2015, Stephen Boyd wrote:

> On pm8xxx PMICs, shutdown and restart are signaled to the PMIC
> via a pin called PS_HOLD. When this pin goes low, the PMIC
> performs a configurable power sequence. Add a .shutdown hook so
> that we can properly configure this power sequence for shutdown
> or restart depending on the system state.
> 
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/input/misc/pmic8xxx-pwrkey.c | 284 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 277 insertions(+), 7 deletions(-)
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
