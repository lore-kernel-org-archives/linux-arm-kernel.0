From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Apr 2012 19:00:38 -0300
Subject: Tegra board file deprecation schedule
In-Reply-To: <4F9B1568.9070704@wwwdotorg.org>
References: <4F9B0E7C.1060408@wwwdotorg.org>
 <CAOesGMh3NY4cQERSQY-p0QsMtcCXyhkdGSGnnrckcz8-DPjbBw@mail.gmail.com>
 <4F9B1568.9070704@wwwdotorg.org>
Message-ID: <CAOMZO5Cnd9knDUuc4aZrPrtk5YKUwpr-oJhUnu=z94=9CfY1ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 6:53 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> The only one sticking point might be that the Harmony regulator
> initialization needs to wait for the regulator driver to be probed, but
> happen before the PCIe driver is registers. Perhaps we could hook up
> some temporary bus notifiers to handle that. But since PCIe will likely
> be fixed in 3.6, we could probably just wait for that on Harmony.

Does EPROBE_DEFER help in this case?
