From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 10:11:15 -0300
Subject: [PATCH v4 0/6] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
 <20121128025217.GC18593@nchen-desktop>
 <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CAOMZO5ArDLKDLEzhYc7EP2CNQGcT=vO7ctbiEsjzsGs+EaT7Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Thu, Jan 24, 2013 at 7:42 AM, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Peter Chen <peter.chen@freescale.com> writes:
>
>> On Tue, Nov 27, 2012 at 05:16:55PM +0100, Michael Grzeschik wrote:
>>> Nearly every SoC from Freescale has this non-core usb registers. This series
>>> adds support for more users of this driver.
>>>
>>> This series is based on Peter Chen's work. Its needed to merge his master branch
>>> before applying this series:
>>>
>>> https://github.com/hzpeterchen/linux-usb.git
>>
>> I have tested it at i.mx6q sabrelite board, it works good.
>>
>> I have pushed your commit to my git, please cc me
>> your coming chipidea patches, thanks.
>>
>> Alex, please add:
>>
>> Reviewed-by: Peter Chen <peter.chen@freescale.com>
>> Tested-by: Peter Chen <peter.chen@freescale.com>
>
> Looks good, queueing this one for submission.

Could you please let us know what is preventing this series to be applied?

Thanks,

Fabio Estevam
