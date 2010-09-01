From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Sep 2010 12:16:02 +0100
Subject: [PATCH v2] MAX8952 PMIC Driver Initial Release
In-Reply-To: <AANLkTi=akjQ2wUp7h4gJfsn52BozMprVn9oKygec-0DU@mail.gmail.com>
References: <1282283036-12641-1-git-send-email-myungjoo.ham@samsung.com>
	<20100820095351.GD13668@rakim.wolfsonmicro.main>
	<1282301229.3084.152.camel@odin>
	<011b01cb496a$cfa773d0$6ef65b70$%kim@samsung.com>
	<20100901091519.GA17032@opensource.wolfsonmicro.com>
	<000801cb49ba$3e1e50f0$ba5af2d0$%kim@samsung.com>
	<AANLkTinUNXmDc=H16gS5EXEAdrGAU=zK4cjsHSh7UQ8Q@mail.gmail.com>
	<001101cb49c0$3fd715c0$bf854140$%kim@samsung.com>
	<AANLkTi=akjQ2wUp7h4gJfsn52BozMprVn9oKygec-0DU@mail.gmail.com>
Message-ID: <20100901111602.GF17548@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 07:36:40PM +0900, Kyungmin Park wrote:

> As your word, first check the ID1 to detect the 8649 and 8952 and read
> ID2 again to distinguish it. But actually we pass the max8952 as
> platform device, so don't need to read ID2.

If you can read the ID from the chip it's always good to do so in order
to verify that the user has supplied accurate information.
