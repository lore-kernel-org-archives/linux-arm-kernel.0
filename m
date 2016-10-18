From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 18 Oct 2016 09:56:01 +0200
Subject: [PATCH 08/19] thermal: sti: Remove obsolete platforms from the DT
 doc.
In-Reply-To: <20160923150815.GD9176@rob-hp-laptop>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-9-git-send-email-peter.griffin@linaro.org>
 <20160923150815.GD9176@rob-hp-laptop>
Message-ID: <cf070457-4bd5-46e1-ff91-7dab047ade55@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 09/23/2016 05:08 PM, Rob Herring wrote:
> On Wed, Sep 14, 2016 at 02:27:46PM +0100, Peter Griffin wrote:
>> STiH415/6 SoC's are being removed from the kernel. This
>> patch removes the compatibles from the dt doc and also
>> updates the example to a supported platform.
>>
>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>> Cc: <rui.zhang@intel.com>
>> Cc: <edubezval@gmail.com>
>> Cc: <robh+dt@kernel.org>
>> ---
>>  .../devicetree/bindings/thermal/st-thermal.txt     | 28 +++++++---------------
>>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>


Applied on sti-dt-for-4.10 branch

Thanks 

> 
