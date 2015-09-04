From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 4 Sep 2015 09:24:02 -0700
Subject: [PATCH v2] clk: rockchip: Add pclk_peri to critical clocks on
 RK3066/RK3188
In-Reply-To: <CABgxDoLgqfzO-Sb_rKHe=-GuMaKWMihHhktx6sDSM6M=Q+Koaw@mail.gmail.com>
References: <1440322357-2621-1-git-send-email-romain.perier@gmail.com>
 <CABgxDo+otZrYoqTNK-ea=L6Dsd5p_b_MFCi4H4XJZZ25PV_qnA@mail.gmail.com>
 <CABgxDoLgqfzO-Sb_rKHe=-GuMaKWMihHhktx6sDSM6M=Q+Koaw@mail.gmail.com>
Message-ID: <20150904162402.GN15099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04, Romain Perier wrote:
> Hi all,
> 
> just a reminder, I sent this patch two weeks ago, rk3xxx-based
> platforms still need it, it fixes a freeze during boot.

Sorry I thought that Linus W was going to pick this up? If not,
we can take it through clk tree as a fix for -rc1.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
