From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Wed, 20 Aug 2014 23:30:15 +0300
Subject: [PATCH v1 1/3] pinctrl: qcom: Add APQ8084 pinctrl support
In-Reply-To: <20140820154200.GA14731@qualcomm.com>
References: <1408468936-12252-1-git-send-email-gdjakov@mm-sol.com>
 <1408468936-12252-2-git-send-email-gdjakov@mm-sol.com>
 <20140820043929.GH7070@sonymobile.com> <20140820154200.GA14731@qualcomm.com>
Message-ID: <53F50557.5070109@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.08.14 18:42, Andy Gross wrote:
> On Tue, Aug 19, 2014 at 09:39:30PM -0700, Bjorn Andersson wrote:
>> On Tue 19 Aug 10:22 PDT 2014, Georgi Djakov wrote:
>>
>>> This patch adds support for the TLMM (Top-Level Mode Mux) block found
>>> in the APQ8084 platform.
>>>
>> [...]
>>> +
>>> +#define NUM_GPIO_PINGROUPS 143
>>> +
>>
>> I think this looks good overall, but in my APQ8084 documentation
>> (80-NG550-2X Rev. B) there are 147 (0..146) gpio pins in the TLMM block.
>>
>> Any suggestion to why there's a discrepancy?
>>
> 
> We have some discrepancies internally on the documentation.  However, in this
> case I'd expect the OEM documentation to be correct.  So this needs to change to
> bjorn's version, as it appears to be the correct version.
> 
> I have no idea why some pins are missing.
> 

Thank you for reviewing, Bjorn and Andy. I'll update and submit v2.

BR,
Georgi
