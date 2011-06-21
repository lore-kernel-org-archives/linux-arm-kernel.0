From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Jun 2011 12:56:57 +0100
Subject: [PATCH v2 1/4] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <4E00853A.7010003@linaro.org>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
	<1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
	<1308622033-2521-2-git-send-email-myungjoo.ham@samsung.com>
	<4E002D18.2080401@linaro.org>
	<20110621111010.GH22177@opensource.wolfsonmicro.com>
	<4E00853A.7010003@linaro.org>
Message-ID: <20110621115657.GE25032@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 05:19:14PM +0530, Tushar Behera wrote:
> On Tuesday 21 June 2011 04:40 PM, Mark Brown wrote:

>> If the board is similar enough in design to be sharing the PMIC code
>> that sounds like it should be sharing a lot more of the board setup
>> code.

> Origen board details can be found at http://www.origenboard.org/

> Under 'Documents' section, there are some schematics for the board.

> As for other peripherals, I am not sure how much similar this is w.r.t.  
> NURI (I don't have NURI board schematics).

Right, and we can't really make the assessment about sharing the code if
we can't do a contrast and compare between the two schematics (or look
at the resulting code).
