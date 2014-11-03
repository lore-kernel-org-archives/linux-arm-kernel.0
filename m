From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 3 Nov 2014 18:46:34 +0100
Subject: [PATCH v4 02/58] serial: at91: Use dmaengine_slave_config API
In-Reply-To: <20141103123311.GJ11263@lukather>
References: <1414531573-18807-1-git-send-email-maxime.ripard@free-electrons.com>
 <1414531573-18807-3-git-send-email-maxime.ripard@free-electrons.com>
 <5457632C.5020002@atmel.com> <20141103123311.GJ11263@lukather>
Message-ID: <5457BF7A.4060105@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 13:33, Maxime Ripard :
> Hi Nicolas,
> 
> On Mon, Nov 03, 2014 at 12:12:44PM +0100, Nicolas Ferre wrote:
>> On 28/10/2014 22:25, Maxime Ripard :
>>> We are removing the dmaengine_device_control API, that shouldn't even have been
>>> exposed in the first place. Change the callers to use the proper API.
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Thanks, Maxime. Do I have to carry the patch myself or is it part of a
>> series?
> 
> I think it would be better to keep it together with that serie, since
> we're removing dmaengine_device_control in a latter patch. If it's ok
> for you of course.

Fair enough, keep it in.

Thanks Maxime, bye,
-- 
Nicolas Ferre
