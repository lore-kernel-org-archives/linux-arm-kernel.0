From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 10 Mar 2014 15:22:48 +0200
Subject: [PATCHv3 00/41] OMAPDSS: DT support v3
In-Reply-To: <20140307164929.GC3789@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <531823C5.1020008@ti.com> <20140307164929.GC3789@atomide.com>
Message-ID: <531DBCA8.80507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/14 18:49, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140305 23:32]:
>> Hi Tony,
>>
>> On 21/01/14 12:56, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> Here's version 3 of the DSS DT series.
>>
>> Can you have a look at the arch/arm/ parts in the series and ack if
>> they're ok, i.e, patches 1, 2, 32.
> 
> Patches 1, 2 & 32 look OK to me, so for those please feel free to add:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

> How about do a pull request for just the .dts changes against current
> omap-for-v3.15/dt branch ASAP for me so I can pull it in? That is assuming
> that just the .dts changes alone won't break anything.

Unfortunately they do break. At least pinmuxing is moved from the global
definitions to be handled by the respective display drivers, and there
are some regulator_name hacks that the DT patches remove.

I think those changes could be removed from my patches, and then added
back later when everything else has been merged.

The bigger issue is that suddenly there's lots of discussion about the
display DT bindings. If those are not resolved very soon, I guess I have
no choice but to again skip the merge window for the DSS DT changes.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/4aede038/attachment.sig>
