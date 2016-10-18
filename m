From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 18 Oct 2016 10:59:15 +0200
Subject: [STLinux Kernel] [PATCH 18/19] stmmac: dwmac-sti: Remove obsolete
 STi platforms
In-Reply-To: <dcbb8065-b272-0a2f-8efb-c55217712caf@st.com>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-19-git-send-email-peter.griffin@linaro.org>
 <20160923151142.GG9176@rob-hp-laptop>
 <dcbb8065-b272-0a2f-8efb-c55217712caf@st.com>
Message-ID: <7b0ce054-b30b-3a8e-23b9-ca3a33a55e31@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/18/2016 10:05 AM, Patrice Chotard wrote:
> 
> 
> On 09/23/2016 05:11 PM, Rob Herring wrote:
>> On Wed, Sep 14, 2016 at 02:27:56PM +0100, Peter Griffin wrote:
>>> This patch removes support for STiH415/6 SoC's from the
>>> dwmac-sti driver and dt binding doc, as support for these
>>> platforms is being removed from the kernel. It also removes
>>> STiD127 related code, which has never actually been supported
>>> upstream.
>>>
>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>> Cc: <peppe.cavallaro@st.com>
>>> Cc: <alexandre.torgue@st.com>
>>> Cc: <netdev@vger.kernel.org>
>>> ---
>>>  .../devicetree/bindings/net/sti-dwmac.txt          |  3 +-
>>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> 
> Applied on sti-dt-for-4.10 branch


Sorry, i did a mistake, these patch should go in stmmac tree.
Peppe or Alexandre will you take care of it ?

Thanks
> 
> Thanks 
> 
>>
>>>  drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    | 37 ----------------------
>>>  2 files changed, 1 insertion(+), 39 deletions(-)
> 
> _______________________________________________
> Kernel mailing list
> Kernel at stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
> 
