From: zecke@selfish.org (Holger Freyther)
Date: Mon, 06 Jun 2011 19:45:48 +0200
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <20110606163210.GC7448@n2100.arm.linux.org.uk>
References: <4DECCADE.6080100@selfish.org>
	<alpine.LFD.2.02.1106061518480.13964@ionos>
	<20110606163210.GC7448@n2100.arm.linux.org.uk>
Message-ID: <4DED124C.50205@selfish.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2011 06:32 PM, Russell King - ARM Linux wrote:
Hi Russell,

thanks for your time and sorry for sending a truncated kernel oops. In the
other part of the thread we found that the davinci GPIO code overrides the IRQ
chip data.


> Unless we have the Code: line we don't know what the code being executed
> was.  It's important that folk always report the entire oops dump, not
> extracts from it that they _think_ may be relevant.

is it still useful to send a complete oops, or do you think the issue is fully
understood?

holger
