From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 29 Mar 2014 12:50:07 -0700
Subject: [PATCH v5 0/9] Use regmap+devm+DT in pm8xxx input drivers
In-Reply-To: <1393958088-1456-1-git-send-email-sboyd@codeaurora.org>
References: <1393958088-1456-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140329195007.GA14270@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 10:34:39AM -0800, Stephen Boyd wrote:
> These patches move the pm8xxx input drivers over to use devm_* APIs
> and regmap. This breaks the dependency of these drivers on the pm8xxx
> specific read/write calls and also simplifies the probe code a bit.
> Finally we add devicetree support to these drivers so they can be probed
> on the platforms that are supported upstream.

Applied all (and folded DT binding patches into respective driver
changes).

-- 
Dmitry
