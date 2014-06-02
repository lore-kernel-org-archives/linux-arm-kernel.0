From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Mon, 02 Jun 2014 23:49:47 +0300
Subject: [PATCH v2 3/4] ARM: dts: qcom: Add APQ8084 Global Clock Controller
 DT node
In-Reply-To: <DDE79254-2F56-47AC-A689-5A0E8E131126@codeaurora.org>
References: <1401551134-28485-1-git-send-email-gdjakov@mm-sol.com>
 <1401551134-28485-4-git-send-email-gdjakov@mm-sol.com>
 <DDE79254-2F56-47AC-A689-5A0E8E131126@codeaurora.org>
Message-ID: <538CE36B.8030708@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.06.14, 23:41, Kumar Gala wrote:
> 
> On May 31, 2014, at 10:45 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
> 
>> This patch adds the necessary node to probe the global clock
>> controller on APQ8084 platforms.
>>
>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
>> ---
>> arch/arm/boot/dts/qcom-apq8084.dtsi |   10 ++++++++++
>> 1 file changed, 10 insertions(+)
> 
> Can you split the 2 DT patches into their own patchset since they will go via the qcom/arm-soc tree and not Mike?s clk tree.
> 
> thanks
> 

Sure! Thanks!
