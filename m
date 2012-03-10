From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 10 Mar 2012 18:51:13 +0100
Subject: [PATCH v6 2/3] clk: introduce the common clock framework
In-Reply-To: <1331366064-1273-3-git-send-email-mturquette@linaro.org>
References: <1331366064-1273-1-git-send-email-mturquette@linaro.org>
 <1331366064-1273-3-git-send-email-mturquette@linaro.org>
Message-ID: <20120310175113.GK16608@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 11:54:23PM -0800, Mike Turquette wrote:
> The common clock framework defines a common struct clk useful across
> most platforms as well as an implementation of the clk api that drivers
> can use safely for managing clocks.

Hi Mike

Please feel free to add:

Tested-by: Andrew Lunn <andrew@lunn.ch>

	   Andrew
