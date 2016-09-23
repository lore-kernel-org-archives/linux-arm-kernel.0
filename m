From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 10:12:05 -0500
Subject: [PATCH 19/19] reset: sti: softreset: Remove obsolete platforms
 from dt binding doc.
In-Reply-To: <1473859677-9231-20-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-20-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160923151205.GH9176@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 02:27:57PM +0100, Peter Griffin wrote:
> STiH415/6 SoC support is being removed from the kernel.
> This patch updates the sti dt softreset bindings and
> removes references to these obsolete platforms.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <p.zabel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/reset/st,sti-softreset.txt | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
