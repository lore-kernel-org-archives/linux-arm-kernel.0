From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 10:59:07 +0200
Subject: [PATCH 1/2] net: flexcan: clock-frequency is optional for device
 tree probe
In-Reply-To: <20120627085600.GB9787@S2101-09.ap.freescale.net>
References: <1340700563-8386-1-git-send-email-shawn.guo@linaro.org>
 <1340700563-8386-2-git-send-email-shawn.guo@linaro.org>
 <4FEAC89C.3000405@pengutronix.de>
 <20120627085600.GB9787@S2101-09.ap.freescale.net>
Message-ID: <4FEACB5B.2040508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2012 10:56 AM, Shawn Guo wrote:
> On Wed, Jun 27, 2012 at 10:47:24AM +0200, Marc Kleine-Budde wrote:
>> On 06/26/2012 10:49 AM, Shawn Guo wrote:
>>> The property clock-frequency is optional for device tree probe.  When
>>> it's absent, the flexcan driver will try to get the frequency from clk
>>> system by calling clk_get_rate.
>>>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Thanks.
> 
>>
>> As Oliver pointed out, this doesn't go through the net tree.
>>
> From what I have seen, device tree maintainers are generally fine with
> having binding document updates go through subsystem tree.

Okay. Then I'll take that patch.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/80807306/attachment.sig>
