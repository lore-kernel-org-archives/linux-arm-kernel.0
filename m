From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 4 Apr 2017 18:38:15 -0700
Subject: [PATCH 0/3] arm: dts: renesas: Drop _clk suffix from clock node
 names
In-Reply-To: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
References: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170405013815.GK18246@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> The current practice is to not add _clk suffixes to clock node names in
> DT, as these names are used as the actual clock names.
> 
> This patch removes the remaining offenders in the various Renesas DTSes.
> 

This changes the names in the clk framework too though? If you're
ok with that I'm ok too.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
