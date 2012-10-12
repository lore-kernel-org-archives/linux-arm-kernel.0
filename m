From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 12 Oct 2012 16:50:27 +0200
Subject: [PATCH V2 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <9688d98010716880c1bbd966ead312c446282204.1350051925.git.viresh.kumar@linaro.org>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350051925.git.viresh.kumar@linaro.org>
 <9688d98010716880c1bbd966ead312c446282204.1350051925.git.viresh.kumar@linaro.org>
Message-ID: <20121012145027.GF12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:01 Fri 12 Oct     , Viresh Kumar wrote:
> dw_dmac driver already supports device tree but it used to have its platform
> data passed the non-DT way.
> 
> This patch does following changes:
> - pass platform data via DT, non-DT way still takes precedence if both are used.
why keep it  all platform are DT

Best Regards,
J.
