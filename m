From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Sep 2016 12:08:26 -0300
Subject: [PATCH] serial: imx: Fix DCD reading
In-Reply-To: <CAOMZO5B0Dkx8NTJPrNwR4WE1JJQEY1vczV=d1OtROzzDOGfQAQ@mail.gmail.com>
References: <20160926135531.31888-1-s.hauer@pengutronix.de>
 <20160926140938.ikjatvprk3t4lsed@pengutronix.de>
 <CAOMZO5Aw8pkt_tnM=M0SewN-Xjqq84E-mef-ewGs8aTv0xcHjQ@mail.gmail.com>
 <20160926142506.ix53ekhykp2svodu@pengutronix.de>
 <CAOMZO5B0Dkx8NTJPrNwR4WE1JJQEY1vczV=d1OtROzzDOGfQAQ@mail.gmail.com>
Message-ID: <CAOMZO5CfE49mNM2xawY+2+WUyoMie41+NF8NWp_rWF4DFk9-3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2016 at 11:28 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Uwe,
>
> On Mon, Sep 26, 2016 at 11:25 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
>
>>> Great, so it affects 4.5+ kernels and should probably have:
>>>
>>> Cc: <stable@vger.kernel.org> # 4.5+
>>
>> This is usually not necessary if there is a Fixes: line.
>
> I thought Greg prefers the explicit Cc: stable line as documented in
> Documentation/stable_kernel_rules.txt.
>
> Greg?

Ok, in this previous discussion Greg stated that he prefers Cc: stable
to be present:
http://www.spinics.net/lists/linux-gpio/msg10659.html
