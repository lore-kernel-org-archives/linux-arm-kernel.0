From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 Sep 2015 07:52:46 +0100
Subject: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
In-Reply-To: <20150916043328.GA29943@linux>
References: <20150909075930.GB3260@x1> <20150909083031.GB5266@linux>
 <20150909133930.GE3260@x1> <20150909160212.GJ5266@linux>
 <20150909163620.GF3260@x1> <55F0C5AB.5060609@kernel.org>
 <20150910005722.GA15099@codeaurora.org>
 <20150910010426.GM5266@linux> <20150910083146.GG3260@x1>
 <20150916043328.GA29943@linux>
Message-ID: <20150916065246.GA3218@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Sep 2015, Viresh Kumar wrote:

> On 10-09-15, 09:31, Lee Jones wrote:
> > I think you answered your own question.
> > 
> > No users == !ABI == Strip it out.
> 
> Okay, as I have delayed things enough for you, didn't wanted to do
> that anymore. And so worked on it despite very tight schedule :)
> 
> Below is the refreshed binding changes (I have split that into 3
> patches, but kept the diff here for simplicity).
> 
> Other than that, all code changes you need to test your driver are
> pushed here:
> 
> https://git.linaro.org/people/viresh.kumar/linux.git opp/supported-hw-prop-name-v1
> 
> I am not gonna post the patches to the lists, until the time existing
> patches get reviewed.

Thanks dude.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
