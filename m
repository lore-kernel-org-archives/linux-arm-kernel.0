From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 30 Jan 2015 07:46:52 -0800
Subject: [PATCH] regulator: qcom-rpm: Make it possible to specify supply
In-Reply-To: <54CB4779.6070107@linaro.org>
References: <1422577377-31986-1-git-send-email-bjorn.andersson@sonymobile.com>
 <54CB4779.6070107@linaro.org>
Message-ID: <20150130154651.GS11960@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 30 Jan 00:57 PST 2015, Srinivas Kandagatla wrote:

> Hi Bjorn,
> Thanks for sending this patch.. I almost forgot about this.
> 
> Shouldn?t we update the DT Bindings with this info?
> 

At this time we don't have any bindings for the subnodes merged. So I also sent
out [1] yesterday, including this property. Seems I forgot linux-arm-msm
though.

> Other than that:
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 

Thanks

[1] https://lkml.org/lkml/2015/1/29/1077

Regards,
Bjorn
