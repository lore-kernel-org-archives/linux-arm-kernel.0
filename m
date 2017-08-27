From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Aug 2017 12:41:46 +0200
Subject: [RFC 1/3] dt-bindings: rtc: Add Realtek RTD1295
In-Reply-To: <20170823002911.y35nn7jkt34dvjbc@rob-hp-laptop>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-2-afaerber@suse.de>
 <20170823002911.y35nn7jkt34dvjbc@rob-hp-laptop>
Message-ID: <629b9ed0-7b2d-7c5c-20b8-17289a76f097@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am 23.08.2017 um 02:29 schrieb Rob Herring:
> On Sun, Aug 20, 2017 at 03:36:29AM +0200, Andreas F?rber wrote:
>> Add a binding for the RTC on the Realtek RTD119x/RTD129x SoC families.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  .../devicetree/bindings/rtc/realtek,rtd119x.txt          | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks. Did you read the RFC question in the cover letter as well and
have any comments? Downstream has an rtc-base-year = <2014>; property
that I had left out in this RFC and due to your ack not included in v2.

Should we default to 2014 in the driver and add an optional base-year
property once we encounter a diverging device, or should we make it
required from the beginning? I did not spot any other rtc binding with
such a property and would appreciate a clarification.

Thanks in advance,

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
