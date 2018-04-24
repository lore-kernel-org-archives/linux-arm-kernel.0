From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 24 Apr 2018 16:59:07 +0100
Subject: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR bus bindings
In-Reply-To: <20180424155739.GC22073@sirena.org.uk>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
 <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
 <20180424155739.GC22073@sirena.org.uk>
Message-ID: <0cb15e17-7169-cfee-c444-d14743797ed3@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/04/18 16:57, Mark Brown wrote:
> On Tue, Apr 24, 2018 at 10:52:26AM -0500, Rob Herring wrote:
>> On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla at linaro.org wrote:
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
>>> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
>>> bus driver. This bus is used for communicating with DSP which provides
>>> audio and various other services to cpu.
> 
>> This should probably go under bindings/sound/ as it is at least mostly
>> sound related.
> 
> AIUI the same interface is used for other DSP functionality - they're
> upstreaming audio stuff right now but I believe there should be more to
> come.
> 
That's correct, this is not just for audio, APR is used for other dsp 
services too.

--srini
