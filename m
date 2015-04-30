From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Apr 2015 23:22:11 -0300
Subject: [PATCH] ARM: dts: imx5: Add dts files for USB armory.
In-Reply-To: <20150428081959.GA32234@shlinux2>
References: <87h9t6i40r.fsf@aikidev.net> <20150427115747.GA11975@dragon>
 <20150427133708.GC11598@core.inversepath.com>
 <20150428081959.GA32234@shlinux2>
Message-ID: <CAOMZO5B5bAXhvdv_MUBL9DoMvfv0p25B6eGMLbO1pJuK8HFLVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Apr 28, 2015 at 5:20 AM, Peter Chen <peter.chen@freescale.com> wrote:

> Current chipidea usb driver supports role switch function well, if you
> have a gpio or id pin for it.

On mx6 we are able to perform OTG role-switch funtion as they have the
OTG_ID pins.

We are talking about mx53 here, which does not have such OTG_ID pins,
so not sure how they can perform role-switch in run-time?

Regards,

Fabio Estevam
