From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 13 Sep 2013 11:04:24 +0800
Subject: [Question] Verification For arm64: suspend/resume implementation
In-Reply-To: <52327E41.1070904@marvell.com>
References: <52327E41.1070904@marvell.com>
Message-ID: <20130913110424.0dfd4489@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On Thu, 12 Sep 2013 19:53:53 -0700
Leo Yan <leoy@marvell.com> wrote:

> hi Lorenzo,
> 
> I have applied your ARM64's suspend/resume related patches and can built 
> successfully. i want to verify these patches on foundation model 
> firstly, so below are my questions:
> 
> "Code has been tested on AEM v8 models and a simple CPU idle driver that 
> enables a C-state where CPUs are reset when wfi is hit."
> 
> 1. Can u help share this simple cpu idle driver?
> 2. On the foundation model, if the core is placed into reset state, then 
> if there have interrupt is routed to the core, the core still cannot be 
> waken up anymore; because the reset bit cannot be released by h/w. So 
> how can let the core return back from the reset state?
> 


Does marvell have Fast models' license? Where could I get such license? 
I'm using the evaluation version.


Thanks
