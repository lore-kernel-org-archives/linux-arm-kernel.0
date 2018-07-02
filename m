From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 2 Jul 2018 07:04:22 +0200
Subject: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180617070527.GL16091@dragon>
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
 <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
 <2307533.g32PyNi9fl@aspire.rjw.lan> <20180617070527.GL16091@dragon>
Message-ID: <20738ca3-4289-9e44-ff74-9099b5b8c2b6@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

it is two weeks since this email. Probably it was lost some where in the
space time continuum.
Can you please respond to it :)

On 17.06.2018 09:05, Shawn Guo wrote:
> On Tue, Jun 12, 2018 at 04:33:05PM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, June 12, 2018 2:42:12 PM CEST Oleksij Rempel wrote:
>>>  This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
>>> --Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924
>>> Content-Type: multipart/mixed; boundary="d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg";
>>>  protected-headers="v1"
>>> From: Oleksij Rempel <o.rempel@pengutronix.de>
>>> To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
>>>  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>> Cc: kernel at pengutronix.de, devicetree at vger.kernel.org,
>>>  linux-arm-kernel at lists.infradead.org, linux-clk at vger.kernel.org,
>>>  linux-kernel at vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
>>>  Liam Girdwood <lgirdwood@gmail.com>,
>>>  Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
>>>  Mark Rutland <mark.rutland@arm.com>,
>>>  Michael Turquette <mturquette@baylibre.com>,
>>>  Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
>>>  Russell King <linux@armlinux.org.uk>
>>> Message-ID: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
>>> Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
>>> References: <20180517055014.6607-1-o.rempel@pengutronix.de>
>>>  <20180517055014.6607-4-o.rempel@pengutronix.de>
>>> In-Reply-To: <20180517055014.6607-4-o.rempel@pengutronix.de>
>>>
>>> --d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg
>>> Content-Type: text/plain; charset=utf-8
>>> Content-Language: en-US
>>> Content-Transfer-Encoding: quoted-printable
>>>
>>> Hi Rafael,
>>>
>>> Last version of this patch was send at 17.05.2018. No other comment was
>>> provided and this patch is a blocker for other patches in this serie.
>>> Can you please give some feedback on it.
>>
>> I would have done that had I not missed the patch.
>>
>> Which probably wouldn't have happened had you CCed it to linux-pm.
>>
>> Anyway, I have no particular problems with exporting pm_power_off_prepare via
>> EXPORT_SYMBOL_GPL().
> 
> Rafael,
> 
> Can we have your explicit Acked-by tag on this patch?  Thanks.
> 
> Shawn
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180702/948eac3a/attachment-0001.sig>
