From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 19 Aug 2014 21:39:30 -0700
Subject: [PATCH v1 1/3] pinctrl: qcom: Add APQ8084 pinctrl support
In-Reply-To: <1408468936-12252-2-git-send-email-gdjakov@mm-sol.com>
References: <1408468936-12252-1-git-send-email-gdjakov@mm-sol.com>
 <1408468936-12252-2-git-send-email-gdjakov@mm-sol.com>
Message-ID: <20140820043929.GH7070@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 19 Aug 10:22 PDT 2014, Georgi Djakov wrote:

> This patch adds support for the TLMM (Top-Level Mode Mux) block found
> in the APQ8084 platform.
> 
[...]
> +
> +#define NUM_GPIO_PINGROUPS 143
> +

I think this looks good overall, but in my APQ8084 documentation
(80-NG550-2X Rev. B) there are 147 (0..146) gpio pins in the TLMM block.

Any suggestion to why there's a discrepancy?

Regards,
Bjorn
