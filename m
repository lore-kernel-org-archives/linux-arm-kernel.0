From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 10:11:12 -0700
Subject: [PATCHv7 2/3] arm64: dts: stratix10: use clock bindings for the
 Stratix10 platform
In-Reply-To: <1521642012-9770-2-git-send-email-dinguyen@kernel.org>
References: <1521642012-9770-1-git-send-email-dinguyen@kernel.org>
 <1521642012-9770-2-git-send-email-dinguyen@kernel.org>
Message-ID: <152303467206.143116.7701915429594440149@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dinh Nguyen (2018-03-21 07:20:11)
> Use the clock bindings for the Stratix10 SoC. This includes changing the old
> binding of "intc,clk-s10-mgr" to "intel,stratix10-clkmgr". The reason that
> this can be done is that there are currently no clock driver for Stratix10,
> thus there are no consumers of the old binding. So changing the binding will
> not break any legacy code.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

This should go via arm-soc so I won't be apply this one.
