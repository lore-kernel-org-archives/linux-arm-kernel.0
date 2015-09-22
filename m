From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 22 Sep 2015 09:39:46 -0700
Subject: [PATCH v2 1/5] regulator: smd: Add floor and corner operations
In-Reply-To: <20150919165712.GH30445@sirena.org.uk>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
 <1442623929-4507-2-git-send-email-sboyd@codeaurora.org>
 <20150919165712.GH30445@sirena.org.uk>
Message-ID: <20150922163946.GG23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19, Mark Brown wrote:
> On Fri, Sep 18, 2015 at 05:52:05PM -0700, Stephen Boyd wrote:
> 
> > +EXPORT_SYMBOL(qcom_rpm_set_floor);
> 
> The entire regulator API is EXPORT_SYMBOL_GPL(), adding plain
> EXPORT_SYMBOL() exports is not good.

That's fine. I can make it GPL.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
