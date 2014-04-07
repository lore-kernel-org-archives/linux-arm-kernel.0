From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 07 Apr 2014 18:22:30 +0300
Subject: [PATCH v2] clk: qcom: Add support for IPQ8064's global clock
 controller (GCC)
In-Reply-To: <AF6AA9C9-6A47-4394-91FD-F7F0C264C530@codeaurora.org>
References: <1396642749-12979-1-git-send-email-galak@codeaurora.org>
 <1396882918.28420.37.camel@iivanov-dev>
 <AF6AA9C9-6A47-4394-91FD-F7F0C264C530@codeaurora.org>
Message-ID: <1396884150.28420.38.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 10:10 -0500, Kumar Gala wrote:
> On Apr 7, 2014, at 10:01 AM, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:
> 
> > Hi Kumar,

<snip>
> > 
> >> --- /dev/null
> >> +++ b/drivers/clk/qcom/gcc-ipq806x.c
> >> @@ -0,0 +1,1957 @@
> >> +/*

<snip>

> >> +#include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> >> +#include <dt-bindings/reset/qcom,gcc-ipq806x.h>
> >> +
> >> +#include "common.h"
> > 
> > Do I miss something or this file is not available?
> 
> Its based on Stephen?s refactoring patch:
> 
> https://patchwork.kernel.org/patch/3876761/
> 

Thanks, 
Ivan

> - k
> 
