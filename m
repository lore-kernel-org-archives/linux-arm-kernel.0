From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 28 Aug 2018 15:39:47 -0700
Subject: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
In-Reply-To: <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <153549598745.129321.12633089552143824401@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Vabhav Sharma (2018-08-19 23:47:14)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> As LX2160A is 16 core, so modified value for NUM_CMUX
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
