From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 19:55:09 -0700
Subject: [PATCH] ARM: tegra: harmony: fix ldo7 regulator-name
In-Reply-To: <1348176039-6094-1-git-send-email-swarren@wwwdotorg.org>
References: <1348176039-6094-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120921025509.GA19276@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 03:20:39PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> On Harmony, LDO7 does not feed vdd_fuse. Correct the regulator name.
> This issue was probably the result of copying Ventana's regulator setup
> when creating the Harmony .dts file. No other naming issues appear to
> exist.
> 
> Reported-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Arnd, Olof, any chance you could roll this into arm-soc directly rather than
> my sending another pull request? Or, I can re-do my today's dt2 pull request
> with this added if it makes it easier. Thanks.
> 
> I don't expect any more patches to show up for Tegra for 3.7, unless they're
> bug-fixes for issues I haven't noticed yet.

Sure, applied to next/cleanup, since that's where the regulator code was added
(through board-removal).


-Olof
