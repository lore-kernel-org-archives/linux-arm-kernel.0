From: socketcan@hartkopp.net (Oliver Hartkopp)
Date: Mon, 03 Nov 2014 22:12:10 +0100
Subject: [PATCH 1/7] can: m_can: fix possible sleep in napi poll
In-Reply-To: <5457EA62.5040906@pengutronix.de>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
 <5457B517.8030805@pengutronix.de> <5457CB6B.3080002@hartkopp.net>
 <5457EA62.5040906@pengutronix.de>
Message-ID: <5457EFAA.5010804@hartkopp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2014 09:49 PM, Marc Kleine-Budde wrote:
> On 11/03/2014 07:37 PM, Oliver Hartkopp wrote:

>> If possible I would suggest to push all 7 patches via can/master as it is
>> pretty bad to say "M_CAN was introduced in 3.18 but M_CAN with CAN FD is
>> working since 3.19".
> 
> Sorry, probably not, as CAN FD is a new feature. However we may talk to
> David, as the m_can driver was introduced in 3.18 anyways, so it's
> unlikely to break anything with this patch.
> 

Yes. It's just to be 'feature complete' for the FD enabled M_CAN driver.
Hopefully it's ok for Dave ...

Thanks,
Oliver
