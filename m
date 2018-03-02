From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Mar 2018 09:53:19 -0600
Subject: [PATCH v1 02/19] dt-bindings: cpufreq: mediatek: use - instead
 of _ in examples
In-Reply-To: <fd1fc4c6760ab8fcbf7518df1cecf3837ab18d2c.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <fd1fc4c6760ab8fcbf7518df1cecf3837ab18d2c.1519378871.git.sean.wang@mediatek.com>
Message-ID: <20180302155319.xvp2awguosm7kyyo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 06:16:22PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> It should be good that no use "_" is in examples. Consequently,
> those nodes in certain files which have an inappropriate name containing
> "_" are all being replaced with "-".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-pm at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
