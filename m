From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Tue, 19 May 2015 11:52:40 -0700
Subject: [PATCH 2/2] ARM: dts: sabrelite: use simple-panel instead of
 display-timings for LVDS0
In-Reply-To: <555B6A0B.4010205@boundarydevices.com>
References: <20150518075844.7e1b5916@ipc1.ka-ro>	
 <1432050616-11465-1-git-send-email-eric.nelson@boundarydevices.com>	
 <1432050616-11465-3-git-send-email-eric.nelson@boundarydevices.com>
 <1432051452.15181.48.camel@pengutronix.de>
 <555B6A0B.4010205@boundarydevices.com>
Message-ID: <555B8678.8090002@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 05/19/2015 09:51 AM, Eric Nelson wrote:
> On 05/19/2015 09:04 AM, Philipp Zabel wrote:
>> Hi Eric,
>>
>> Am Dienstag, den 19.05.2015, 08:50 -0700 schrieb Eric Nelson:
>>> Also add label for backlight_lvds and connect it to the LVDS display.
>>>
>>> Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
>>> ---
>> [...]
>>>  
>>>  &audmux {
>>> @@ -374,18 +385,11 @@
>>>  		fsl,data-width = <18>;
>>
>> The fsl,data-width property shouldn't be needed anymore if you
>> set .bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG for the hsd100pxn1
>> panel in panel-simple.c.
>>

Are you planning to submit a patch to panel-simple.c for this?

Because of the dependency, I'd like to handle this in a separate
patch instead of V3 of this patch set.

Please advise,


Eric
