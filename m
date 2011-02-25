From: davidb@codeaurora.org (David Brown)
Date: Thu, 24 Feb 2011 19:54:21 -0800
Subject: [PATCH v2 2/2] msm: add single-wire serial bus interface (SSBI)
	driver
In-Reply-To: <20110225032856.GA8475@suse.de> (Greg KH's message of "Thu, 24
	Feb 2011 19:28:56 -0800")
References: <1298585954-22422-1-git-send-email-kheitke@codeaurora.org>
	<1298585954-22422-3-git-send-email-kheitke@codeaurora.org>
	<1298600621.17118.27.camel@m0nster>
	<8yad3mgdeut.fsf@huya.qualcomm.com>
	<1298601346.17118.29.camel@m0nster>
	<AANLkTikD1Ued=rit1QbMWwe3NGFz2iQ-KO7B=-N6Ok-2@mail.gmail.com>
	<8ya8vx4dcky.fsf@huya.qualcomm.com> <20110225032856.GA8475@suse.de>
Message-ID: <8yavd08bwgi.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24 2011, Greg KH wrote:

> drivers/ssbi?  What's keeping this from later moving off of the msm
> chips to run on others?  USB started out only on one processor, as did a
> lot of other bus-specific drivers, before the hardware became present on
> other architectures.  So no need to bury it under a msm specific
> location.

Not sure if anything is stopping it from moving off of MSM chips, but it
doesn't seem very likely.  There are too many similar interfaces that
are standard that others would be likely to use.  For the most part, it
is the bus to communicate between the MSM and it's specialized
peripherals.

We can still put it there, but it will likely be the only driver ever in
the directory.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
