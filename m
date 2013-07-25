From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 25 Jul 2013 08:43:38 -0700
Subject: [PATCH 05/22] ARM: dts: bcm281xx: Remove '0x's from BCM11351 BRT
 DTS file
In-Reply-To: <51ED6486.3080700@broadcom.com>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-5-git-send-email-lee.jones@linaro.org>
 <51ED2D90.4020209@broadcom.com> <20130722133852.GA26801@laptop>
 <51ED3971.905@broadcom.com> <51ED6486.3080700@broadcom.com>
Message-ID: <CAAYSxhrf+WNz1+ojA1r_pOLWg4xf9Ko8OyUc4GfVEMUN776pfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 9:57 AM, Christian Daudt <csd@broadcom.com> wrote:

> it'd be nice to have something to point
> people to as this being the best practice for kernel dev.

Power.org's ePAPR exclusively omits the 0x in the unit-address of node names.

https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf
