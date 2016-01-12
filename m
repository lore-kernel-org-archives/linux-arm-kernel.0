From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Jan 2016 14:18:53 +0000
Subject: [PATCH 2/5] arm64: dts: apq8016-sbc: move sdhci node under soc
 node
In-Reply-To: <18094818.3Fy0P66y0u@wuerfel>
References: <1452606358-24569-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1452606412-24659-1-git-send-email-srinivas.kandagatla@linaro.org>
 <18094818.3Fy0P66y0u@wuerfel>
Message-ID: <56950B4D.3030707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/16 14:00, Arnd Bergmann wrote:
> On Tuesday 12 January 2016 13:46:52 Srinivas Kandagatla wrote:
>> To be consistent with other nodes move sdhci node under the soc node,
>> rather than using lable references.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>
> Maybe remove the label as well if you are no longer using it?
Label "sdhc_1" in this case is used in aliases node.

>
My understanding so far was qcom specific dt want to use hierarchical dt 
nodes in the board files, but this brings the question of should we 
delete all the unused labels.

IMO, some unused labels are harmless and would give more consistency to 
the reader, removing them might not add great value.

Andy/Stephen, any comments?


--srini

> 	Arnd
>
