From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 19 Nov 2016 11:42:09 +0000
Subject: [PATCH v3 1/6] Documentation: dt-bindings: Document STM32 ADC DT
 bindings
In-Reply-To: <20161116151549.m6phclc6cqy4lj2y@rob-hp-laptop>
References: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
 <1479223861-21747-2-git-send-email-fabrice.gasnier@st.com>
 <20161116151549.m6phclc6cqy4lj2y@rob-hp-laptop>
Message-ID: <31b94d46-7786-8a3b-3b41-b4ce2b4ae945@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/16 15:15, Rob Herring wrote:
> On Tue, Nov 15, 2016 at 04:30:56PM +0100, Fabrice Gasnier wrote:
>> This patch adds documentation of device tree bindings for the STM32 ADC.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 83 ++++++++++++++++++++++
>>  1 file changed, 83 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
