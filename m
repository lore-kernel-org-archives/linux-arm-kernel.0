From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 28 Aug 2015 12:52:40 -0700
Subject: [PATCH] soc: qcom: Reorder SMEM/SMD configs
In-Reply-To: <1440786213-23375-1-git-send-email-sboyd@codeaurora.org>
References: <1440786213-23375-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150828195239.GR13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 28 Aug 11:23 PDT 2015, Stephen Boyd wrote:

> When I make nconfig, having the SMEM option after the SMD option
> causes the configurator to get confused when I'm enabling and
> disabling these options. Let's move SMEM before SMD so there's a
> clear indented dependency chain.
> 
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
