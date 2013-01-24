From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 24 Jan 2013 11:42:53 +0200
Subject: [PATCH v4 0/6] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <20121128025217.GC18593@nchen-desktop>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
 <20121128025217.GC18593@nchen-desktop>
Message-ID: <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> On Tue, Nov 27, 2012 at 05:16:55PM +0100, Michael Grzeschik wrote:
>> Nearly every SoC from Freescale has this non-core usb registers. This series
>> adds support for more users of this driver.
>> 
>> This series is based on Peter Chen's work. Its needed to merge his master branch
>> before applying this series:
>> 
>> https://github.com/hzpeterchen/linux-usb.git
>
> I have tested it at i.mx6q sabrelite board, it works good.
>
> I have pushed your commit to my git, please cc me
> your coming chipidea patches, thanks.
>
> Alex, please add:
>
> Reviewed-by: Peter Chen <peter.chen@freescale.com>
> Tested-by: Peter Chen <peter.chen@freescale.com>

Looks good, queueing this one for submission.

Regards,
--
Alex
