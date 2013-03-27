From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 27 Mar 2013 15:57:27 +0200
Subject: [PATCH v4 0/6] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <20130327110515.GO22810@pengutronix.de>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
 <20121128025217.GC18593@nchen-desktop>
 <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
 <CAOMZO5ArDLKDLEzhYc7EP2CNQGcT=vO7ctbiEsjzsGs+EaT7Dw@mail.gmail.com>
 <20130325162931.GB22810@pengutronix.de>
 <87wqsujrdm.fsf@ashishki-desk.ger.corp.intel.com>
 <20130327110515.GO22810@pengutronix.de>
Message-ID: <87fvzhj67s.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <mgr@pengutronix.de> writes:

> On Tue, Mar 26, 2013 at 02:08:05PM +0200, Alexander Shishkin wrote:
>> Michael Grzeschik <mgr@pengutronix.de> writes:
>> > Hi Alexander, Fabio, Greg,
>
> [...]
>
>> > 618bfec Revert "USB: chipidea: add vbus detect for udc"
>> 
>> This one, though, I will pick.
>
> I miss that patch in your posted series.

I haven't decided yet if it is better to apply a revert or to fix the
existing patch for the time being. If you have any opinions on this,
please share.

Regards,
--
Alex
