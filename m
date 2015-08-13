From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 13 Aug 2015 09:54:23 +0530
Subject: [PATCH v8 10/13] arm: dts: qcom: Add #power-domain-cells property
In-Reply-To: <20150811065335.GB2839@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
 <1438857474-20262-11-git-send-email-rnayak@codeaurora.org>
 <20150811065335.GB2839@codeaurora.org>
Message-ID: <55CC1BF7.1040406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2015 12:23 PM, Stephen Boyd wrote:
> On 08/06, Rajendra Nayak wrote:
>> msm8974 has gcc and mmcc nodes, and apq8084 has a gcc node which
>> implement gdsc powerdomains. Add the #power-domain-cells property
>> to them.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>
> This needs to go through  Andy's tree and arm-soc. Also, I don't
> see an update for the binding anywhere. Please update the binding
> too.

Will do, I hope you mean update the bindings in qcom,mmcc.txt and
qcom,gcc.txt?
