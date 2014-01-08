From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 8 Jan 2014 15:32:17 +0200
Subject: [PATCH] video: imxfb: Use regulator API with LCD class for
 powering
In-Reply-To: <20131223082842.GI26070@S2101-09.ap.freescale.net>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
 <20131223082107.GF26070@S2101-09.ap.freescale.net>
 <1387787053.605757144@f413.i.mail.ru>
 <20131223082842.GI26070@S2101-09.ap.freescale.net>
Message-ID: <52CD5361.50205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-23 10:28, Shawn Guo wrote:
> On Mon, Dec 23, 2013 at 12:24:13PM +0400, Alexander Shiyan wrote:
>>> On Sat, Dec 21, 2013 at 03:08:00PM +0400, Alexander Shiyan wrote:
>>>> This patch replaces custom lcd_power() callback with
>>>> regulator API over LCD class.
>>>
>>> FYI.  Denis' effort on this already goes to v13.
>>>
>>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/285326
>>
>> Hmm, OK, but having LCD class could resolve our problems with contrast control.
>> https://www.mail-archive.com/devicetree at vger.kernel.org/msg07660.html
> 
> I just want to make sure you two are aware of each other's work.

So, should I ignore this patch, or...?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/3c6e0b7e/attachment.sig>
