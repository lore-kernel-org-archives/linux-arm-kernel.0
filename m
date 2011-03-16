From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Mar 2011 19:56:32 +0000
Subject: [Qualcomm PM8921 MFD v2 3/6] gpio: pm8xxx-gpio: Add pm8xxx
	gpio driver
In-Reply-To: <20110316195444.GB4000@angua.secretlab.ca>
References: <1299564590-30116-1-git-send-email-adharmap@codeaurora.org>
	<1299564590-30116-4-git-send-email-adharmap@codeaurora.org>
	<20110312093645.GL9347@angua.secretlab.ca>
	<4D810797.4090000@codeaurora.org>
	<20110316195444.GB4000@angua.secretlab.ca>
Message-ID: <20110316195631.GD15605@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 01:54:44PM -0600, Grant Likely wrote:

> Yes, remove the comment.  I'll probably also remove the comment for
> MODULbus and AC97.

In theory there should be more AC'97 GPIO drivers - at least the wm97xx
chips have GPIOs (currently supported by a custom API).  I'm not sure if
anyone will ever have sufficient time and enthusiasm to move them over
to gpiolib, though.
