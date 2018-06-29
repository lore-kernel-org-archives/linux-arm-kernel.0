From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 29 Jun 2018 11:05:34 -0700
Subject: [RFC PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
In-Reply-To: <20180605062046.31437-1-nm@ti.com>
References: <20180605062046.31437-1-nm@ti.com>
Message-ID: <153029553467.143105.13657696052641478062@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Nishanth Menon (2018-06-04 23:20:46)
> K3_ARCH uses TISCI for clocks as well. Enable the same
> for the driver support.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Hi,
> 
> This patch depends on https://marc.info/?l=linux-arm-kernel&m=152817866312732&w=2
> and is an RFC based off next-20180604 and will post formally once
> v4.18-rc1 is available.
> 

Did you plan on sending it again soon? Otherwise I can just merge this
patch now.
