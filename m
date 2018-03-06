From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 6 Mar 2018 09:56:56 +0530
Subject: [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
In-Reply-To: <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-3-jcrouse@codeaurora.org>
 <20180305044221.GC23018@vireshk-i7>
 <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
Message-ID: <20180306042656.GJ23018@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05-03-18, 08:28, Jordan Crouse wrote:
> I'm glad you brought this up - I was trying to find a place in the documentation
> to put it, but since target specific nodes would be a new trick for OPP I didn't
> quite know how to go about doing it. Do we just list them as Optional: or
> should we add a target specific section to the documentation and list them out
> there instead?

Something like this and you need to have your own compatible string as
well:

Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt

But first, what's the purpose of this field? Just to check if it can
be handled by current bindings.

-- 
viresh
