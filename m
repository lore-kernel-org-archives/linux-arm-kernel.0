From: charu@ti.com (Varadarajan, Charulatha)
Date: Thu, 26 May 2011 15:06:55 +0530
Subject: [PATCH 11/15] OMAP: GPIO: Remove hardcoded offsets in ctxt
	save/restore
In-Reply-To: <871uzmo05l.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-12-git-send-email-tarun.kanti@ti.com>
	<871uzmo05l.fsf@ti.com>
Message-ID: <BANLkTimS7XbGQ6sn-uPagq_FuvxopibYfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 04:31, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> It is not required to use hard-coded offsets any more in context
>> save and restore functions and instead use the generic offsets
>> which have been correctly initialized during device registration.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>
> Looks good.
>
> I suggest you move this and all the other patches that just change to using
> regsister offsets earlier in the series.

okay.

>
> Kevin
>
