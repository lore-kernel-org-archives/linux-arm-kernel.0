From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 9 Mar 2012 10:34:19 +0800
Subject: [PATCH v5 0/4] common clk framework
In-Reply-To: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
Message-ID: <20120309023418.GF3261@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

The main interface for clk implementer is to register clocks dynamically.
I think it highly depends on clk DT bindings. From the patch Grant sent
out, it looks like he doesn't like one node per clk. So how do we
register clocks dynamically? You have any sample code?

Thanks
Richard
