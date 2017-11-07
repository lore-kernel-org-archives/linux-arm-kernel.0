From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 7 Nov 2017 14:58:06 +0100
Subject: [PATCH v1 1/2] dt-bindings: display: stm32: add a 2nd endpoint
In-Reply-To: <20171027143809.ughycmycxmsrwwyp@rob-hp-laptop>
References: <1509018489-19641-1-git-send-email-philippe.cornu@st.com>
 <1509018489-19641-2-git-send-email-philippe.cornu@st.com>
 <20171027143809.ughycmycxmsrwwyp@rob-hp-laptop>
Message-ID: <CA+M3ks6edWGXB2Hbi27=fn3AFwkuoq0grh+Wf1+fUtXFJJh1hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-27 16:38 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Thu, Oct 26, 2017 at 01:48:08PM +0200, Philippe Cornu wrote:
>> ltdc can have up to 2 endpoints:
>>  - dpi external gpios: for rgb panels or external bridge ICs.
>>  - dpi internal ios: connected internally to dsi.
>>
>> Note: Refer to the reference manual to know if the dsi is
>> present on your device.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Acked-by: Rob Herring <robh@kernel.org>
>

Applied on drm-misc-next
Thanks

Benjamin
