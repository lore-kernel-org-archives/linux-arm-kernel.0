From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Jan 2013 23:09:48 +0000
Subject: [PATCH V3 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAKohpo=FjZuMOC-wuNc3q_FXbk546ttCLr55GkW9AL0Tz-HoBA@mail.gmail.com>
References: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
 <201212102208.52347.arnd@arndb.de>
 <CAKohpo=FjZuMOC-wuNc3q_FXbk546ttCLr55GkW9AL0Tz-HoBA@mail.gmail.com>
Message-ID: <201301082309.48676.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 December 2012, Viresh Kumar wrote:
> I saw the binding document and it looks it can be applied to dw_dmac
> too, as there is nothing special for it.
> 
> The question is how? We are already late for merge window and this
> one is queued. Supplying a new patch, getting it reviewed/tested and
> being pulled by Linus is not so easy :)
> 
> Two ways:
> - Keep it as is, and i will fix it separately and quickly
> - Drop it :(

It seems we got both lucky and unlucky here, as all the dmaengine patches,
including this set and the generic DT bindings missed out in the end.
So there is time to fix it all for 3.9.

	Arnd
