From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Aug 2015 16:38:41 +0530
Subject: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
In-Reply-To: <20150811151736.GO18282@x1>
References: <20150803034642.GV899@linux> <20150810132247.GH3249@x1>
 <20150811080023.GB5509@linux> <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux> <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux> <20150811132756.GG18282@x1>
 <20150811142812.GJ5509@linux> <20150811151736.GO18282@x1>
Message-ID: <20150812110841.GC20238@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-08-15, 16:17, Lee Jones wrote:
> This would work if we only had a single variable to contend with, but
> what I showed you in my previous example is that we have 3 variables
> to consider; cut (version), pcode and substrate.
> 
> Using the two (simple) examples I provided, how would your suggestion
> look in our case?

So the solution I gave is for picking the microvolt based on pcode.
The other two (cut, substrate) aren't about picking microvolt, but if
the OPP is available or not. Right?

If these terms are generic enough, then we can add something similar
to what you have added..

@Stephen ?

-- 
viresh
