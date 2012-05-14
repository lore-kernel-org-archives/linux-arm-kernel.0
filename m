From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 16:18:33 +0000
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <4FB12981.8050603@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FB12981.8050603@linaro.org>
Message-ID: <201205141618.33954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2012, Lee Jones wrote:
> > You should be using of_regulator_match() for this (I think it's supposed
> > to do an equivalent job...) rather than open coding.
> 
> I've ripped this out completely and the code appears to continue be 
> fully functional. Happy days! :)

Ok, very good!

Of course it would still be helpful to understand the reasons of
the person putting that code in originally, but I'm at least comfortable
with leaving it out for now, and fixing any problems we see in a proper
way after your code is merged.


	Arnd
