From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 17 Jul 2018 06:56:13 +0200
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <AM0PR04MB42115331D2201A6A07D82CEA805C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180716114209.25242-1-o.rempel@pengutronix.de>
 <20180716114209.25242-2-o.rempel@pengutronix.de>
 <20180716151654.GA21819@rob-hp-laptop>
 <AM0PR04MB42115331D2201A6A07D82CEA805C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <15215da0-2de9-a6a9-0a08-1877e27e0fd7@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17.07.2018 06:51, A.s. Dong wrote:
>> -----Original Message-----
>> From: Rob Herring [mailto:robh at kernel.org]
>> Sent: Monday, July 16, 2018 11:17 PM
>> To: Oleksij Rempel <o.rempel@pengutronix.de>
>> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
>> <fabio.estevam@nxp.com>; Mark Rutland <mark.rutland@arm.com>; A.s.
>> Dong <aisheng.dong@nxp.com>; kernel at pengutronix.de; linux-arm-
>> kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-imx <linux-
>> imx at nxp.com>
>> Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: add mu binding doc
>>
>> On Mon, Jul 16, 2018 at 01:42:07PM +0200, Oleksij Rempel wrote:
>>> The Messaging Unit module enables two processors within the SoC to
>>> communicate and coordinate by passing messages (e.g. data, status and
>>> control) through the MU interface.
>>
>> v3? I already gave my R-by on v4 from Dong. Please coordinate your work on
>> this.
> 
> Okay.
> 
> Oleksij, 
> could you re-add the M4 support part in a separate patch based on
> the already acked SCU one?
> I guess you can re-send with the acked one.

Rob, what do you prefer: two patches for one new file or one squashed patch?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/a345ab00/attachment.sig>
