From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 24 Oct 2011 14:54:34 +0200
Subject: [PATCH] rtc: rtc-s3c: Add device tree support
In-Reply-To: <20111013193455.GC18574@ponder.secretlab.ca>
References: <1315064959-16930-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwQdeD=DEFSBqTTJM_EQcc517LPDy4w-N+mbHdH8Eqh=Dg@mail.gmail.com>
	<053801cc8803$43676230$ca362690$%kim@samsung.com>
	<20111013193455.GC18574@ponder.secretlab.ca>
Message-ID: <4EA5600A.3050801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/11 21:34, Grant Likely wrote:
> On Tue, Oct 11, 2011 at 07:48:07PM +0900, Kukjin Kim wrote:
>> Thomas Abraham wrote:
>>>
>>> On 3 September 2011 21:19, Thomas Abraham<thomas.abraham@linaro.org>
>>> wrote:
>>>> Add device tree based discovery support for Samsung's rtc controller.
>>>>
>>>> Cc: Ben Dooks<ben-linux@fluff.org>
>>>> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/rtc/s3c-rtc.txt |   20
>>> ++++++++++++++++++++
>>>>   drivers/rtc/rtc-s3c.c                             |   21
>>> ++++++++++++++++++++-
>>>>   2 files changed, 40 insertions(+), 1 deletions(-)
>>>>   create mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.txt
>>>
>>> Ping. Any comments for this patch? If this looks fine, can this be
>>> considered for 3.2 merge via the Samsung kernel tree.
>>>
>> (Cc'ed Alessandro Zummo who is RTC Subsystem maintainer)
>>
>> I'm ok with this, so if this can be got the ack from Grant and Alessandro,
>> will take this.
>
> Acked-by: Grant Likely<grant.likely@secretlab.ca>

Hi Alessandro,

Applied this in Samsung tree for supporting device tree for upcoming 3.2 
merge window.

If any problems, please let me know before sending to upstream.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
