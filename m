From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 18 Apr 2012 14:27:50 -0700
Subject: [RFC 00/14] Convert Orion to generic clk framework
In-Reply-To: <20120418205325.GQ20478@pengutronix.de>
References: <1334755830-17581-1-git-send-email-andrew@lunn.ch>
 <20120418205325.GQ20478@pengutronix.de>
Message-ID: <CAJOA=zPCYZH_enifwMSSQ+sPyi5Ef2Ojs7LFVL8YjQb4rAdWTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 1:53 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Andrew,
>
> On Wed, Apr 18, 2012 at 03:30:16PM +0200, Andrew Lunn wrote:
>> The generic clock framework is still exhibiting some flux, so these
>> patches are RFC, against 3.4.0-rc3. The changes to the drivers will be
>> least effected by clk flux, while the last patch will probably be most
>> affected. There will also be minor merge conflicts with the DT work.
>>
>
> For some reason your patches do not make it to the list. All we receive
> is the introdutory mail. This happened with your last orion clock series
> also.

I got most the series, but I'm missing patches 2, 11 and 12...

Are these hosted on a public git tree somewhere?

Regards,
Mike
