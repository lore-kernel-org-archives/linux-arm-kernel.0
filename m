From: arun.murthy@stericsson.com (Arun MURTHY)
Date: Tue, 28 Sep 2010 10:36:29 +0200
Subject: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
In-Reply-To: <AANLkTi=0xKWPNn+b1kfPyMTs_mxsYqx+Cd+R1aTZiycg@mail.gmail.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
	<1285659648-21409-4-git-send-email-arun.murthy@stericsson.com>
	<AANLkTi=0xKWPNn+b1kfPyMTs_mxsYqx+Cd+R1aTZiycg@mail.gmail.com>
Message-ID: <F45880696056844FA6A73F415B568C69532DC2FA80@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Sep 28, 2010 at 3:40 PM, Arun Murthy
> <arun.murthy@stericsson.com> wrote:
> > A new element 'name' is added to pwm led platform data structure.
> > This is required to identify the pwm device.
> 
> I cannot see what this name is used for?
> 
This name is referenced in leds-pwm.c and pwm_bl.c. It is passed as a parameter in pwm_request() function.(please refer the next patch i.e PATHC 4/7)
It is used to identify the pwm driver by name.

Thanks and Regards,
Arun R Murthy
-------------
