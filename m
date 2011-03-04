From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Mar 2011 11:12:53 +0000
Subject: [Qualcomm PM8921 MFD 2/6] mfd: pm8xxx: Add irq support
In-Reply-To: <4D701C44.7090506@codeaurora.org>
References: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>
	<1299104001-5240-3-git-send-email-adharmap@codeaurora.org>
	<20110302224616.GB32325@opensource.wolfsonmicro.com>
	<4D6F1B2B.3090706@codeaurora.org>
	<20110303152242.GB32234@opensource.wolfsonmicro.com>
	<4D701C44.7090506@codeaurora.org>
Message-ID: <20110304111253.GA17653@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 02:55:00PM -0800, Abhijeet Dharmapurikar wrote:
> Mark Brown wrote:

>> Could you deal with this with a library instead?

> Can you please clarify what a library means here?

You can share the code without creating a struct device, just have the
driver for each chip call into the common code.
