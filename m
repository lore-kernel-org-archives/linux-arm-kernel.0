From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 26 Apr 2018 13:05:39 +0100
Subject: [PATCH v6 02/24] soc: qcom: Add APR bus driver
In-Reply-To: <20180426113911.GA21755@sirena.org.uk>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
 <20180426113911.GA21755@sirena.org.uk>
Message-ID: <35bf7a17-8d76-285f-987b-bf74e2b8e5b8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/04/18 12:39, Mark Brown wrote:
> On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
>> ARP driver is made as a bus driver so that the apr devices can added removed
> 
> What is the plan for getting this patch merged?  I think the only review
> I've seen from maintainers thus far has been from Rob on the DT binding.
It was initially reviewed by Bjorn and Rohit. I requested Andy to have 
quick look at this.

I was hoping that APR driver would go via Andy's ARM patches. And the 
rest via your tree.

"depends on QCOM_APR" should prevent drivers from building without apr.

> It's obviously going to be a dependency for everything else.
> 
> Also just saw ARP->APR there.
I will fix that!
> 

--srini
