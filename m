From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 3 Apr 2017 20:45:49 +0100
Subject: [PATCH v2 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
In-Reply-To: <20170403164600.siab6ghtoeuxokg5@rob-hp-laptop>
References: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
 <1490963559-32159-2-git-send-email-fabrice.gasnier@st.com>
 <20170403164600.siab6ghtoeuxokg5@rob-hp-laptop>
Message-ID: <4251bdd9-48d6-9b44-ed3d-f7ec8bfee875@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/17 17:46, Rob Herring wrote:
> On Fri, Mar 31, 2017 at 02:32:37PM +0200, Fabrice Gasnier wrote:
>> Add documentation for 'assigned-resolution-bits' dt optional property.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Changes in v2:
>> - rename property from 'st,adc-res' to 'assigned-resolution-bits' so it
>>   is more common.
>> ---
>>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org> 
Thanks.

Applied to the togreg branch of iio.git.  Will push out as testing for
the autobuilders to have a chance to play with it.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
