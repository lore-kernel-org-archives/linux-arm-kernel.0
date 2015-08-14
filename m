From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 14 Aug 2015 10:50:21 +0200
Subject: [PATCH] enable HQVDP for stih410 platform
In-Reply-To: <55CDA81C.6040307@st.com>
References: <1439305964-15641-1-git-send-email-benjamin.gaignard@linaro.org>
 <55CDA81C.6040307@st.com>
Message-ID: <CA+M3ks4PGmyS6ZdrYy708VhvC6f4wNye-i1fMm1oxRDD5mEckw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is fine for me,

Thanks,
Benjamin

2015-08-14 10:34 GMT+02:00 Maxime Coquelin <maxime.coquelin@st.com>:
> Hi Benjamin,
>
>     The title needs to be appended with "ARM: dts:".
>
>     If you agree, I can fix this when applying it.
>
>
> On 08/11/2015 05:12 PM, Benjamin Gaignard wrote:
>>
>> From: Vincent Abriou <vincent.abriou@st.com>
>>
>> Add HQVDP in stih410 devicetree to enable it.
>> HQVDP bindings have been describe in
>> Documentation/devicetree/bindings/gpu/st,stih4xx.txt file.
>>
>> Signed-off-by: Vincent Abriou <vincent.abriou@st.com>
>
> You need also your sign-off here. I will add it too.
>>
>> ---
>>   arch/arm/boot/dts/stih410.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>>
>
> Regards,
> Maxime



-- 
Benjamin Gaignard

Graphic Working Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
