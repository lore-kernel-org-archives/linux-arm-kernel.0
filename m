From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 17 Sep 2010 10:47:53 +0900
Subject: [PATCH] ARM: S5PV210: Add audio support to Goni and Aquila board
In-Reply-To: <4C92C4D3.4010106@samsung.com>
References: <4C8D8233.2060602@samsung.com> <4C92C4D3.4010106@samsung.com>
Message-ID: <03b001cb560a$5bc6ad80$13540880$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanwoo Choi wrote:
> 
> Dear Ben,
> 
> Don't you have any comment this patch?
> Please give your commont for this patch.
> 
> Chanwoo Choi
> 
> Chanwoo Choi wrote:
> > This patch the I2C board information for the WM8994 used in the
Goni/Aquila
> > as audio codec and adds the I2C/I2S platform drivers. Additionlly, to
> > control power consumption have registerd the voltage consumer of WM8994
> > to the regulator framework.
> >
> > Additionally, I explain the constraints of the regulator of WM8994
codec.
> > All these consumer supply of WM8994 codec connected the
regulator(VCC_1.8V)
> > on a circuit diagram. "VCC_1.8V" regulator is always enabled, because it
is
> > used to many devices on Goni/Aquila board. This is required especially
> > when there are many devices physically attached to "VCC_1.8V" and some
of
> > they did not "register" as consumers to "VCC_1.8V". "VCC_1.8V" might be
> > turned off by those who are registered while "unregistered" are still
active.
> >
> > Signed-off-by : Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by : Joonyoung Shim <jy0922.shim@samsung.com>
> > Signed-off-by : Kyungmin Park <kyungmin.park@samsung.com>
> > ---

Hmm...

Please add my e-mail for S5P series later...
I found this patch just now :-(

Will check soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
