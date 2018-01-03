From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 3 Jan 2018 11:49:20 -0800
Subject: [RESEND PATCH v2 13/15] dt-bindings: sound: qcom: Add devicetree
 bindings for apq8096
In-Reply-To: <787ecdc5-66d8-23ee-7136-2a8759c86536@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
 <20180103002835.GW478@tuxbook>
 <787ecdc5-66d8-23ee-7136-2a8759c86536@linaro.org>
Message-ID: <20180103194920.GA478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 03 Jan 08:27 PST 2018, Srinivas Kandagatla wrote:

> 
> 
> On 03/01/18 00:28, Bjorn Andersson wrote:
> > On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla at linaro.org wrote:
> > 
> > > +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> > 
> > Wouldn't it be possible to describe all(?) qdsp based machines in this
> > one document? I.e. should we name it a little bit more generic?
> 
> You mean like downstream ?
> 

I mean that I'm guessing that apq8084, msm8994, msm8998 etc would come
with the same binding document, but a different compatible.

This is fine for now though, we can always rename the file and reword
the description later.

Regards,
Bjorn
