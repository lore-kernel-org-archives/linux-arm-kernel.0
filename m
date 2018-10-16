From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 15:44:54 -0700
Subject: [PATCH v5 3/6] clk: qoriq: increase array size of cmux_to_group
In-Reply-To: <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
 <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153972989460.5275.12653601090217013634@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Vabhav Sharma (2018-10-14 10:08:00)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Increase size of cmux_to_group array, to accomdate entry of
> -1 termination.
> 
> Added -1, terminated, entry for 4080_cmux_grpX.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
