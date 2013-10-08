From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Oct 2013 10:09:24 -0600
Subject: [PATCH 03/10] clk: tegra: Staticize local variables in clk-pll.c
In-Reply-To: <1381231068-6053-3-git-send-email-sachin.kamat@linaro.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
 <1381231068-6053-3-git-send-email-sachin.kamat@linaro.org>
Message-ID: <52542E34.6020806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 05:17 AM, Sachin Kamat wrote:
> Local variables used only in this file are made static.

This might conflict with some of the cod re-org patches that Peter has
sent. Peter, can you please check. If it does, Peter may as well roll
this into his repost of all the Tegra clock patches...
