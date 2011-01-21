From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Fri, 21 Jan 2011 15:28:21 -0800
Subject: Locking in the clk API
In-Reply-To: <alpine.LFD.2.00.1101211618170.8580@xanadu.home>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111031552.GJ3760@linux-sh.org>
	<4D3862DB.5000708@fluff.org>	<20110120185617.GI6335@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>	<AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>	<4D3907BD.4040900@codeaurora.org>	<AANLkTik53zyXytvuAd5zK0_zExfQT3FmOgTr8BexmGeT@mail.gmail.com>
	<alpine.LFD.2.00.1101211618170.8580@xanadu.home>
Message-ID: <4D3A1695.7020707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2011 01:53 PM, Nicolas Pitre wrote:
...
> And... is there really some advantage to turn the clock off in between 
> frames when you're otherwise busy generating them anyway?

For aggressive power management where supported by HW, yes.

- Bryan

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
