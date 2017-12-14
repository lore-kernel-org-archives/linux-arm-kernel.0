From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 14 Dec 2017 12:50:03 -0800
Subject: DT dtc warnings
In-Reply-To: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
References: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
Message-ID: <1dbad435-269f-48e1-c4b1-a6ac6d81eee1@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hui Rob,

12/14/2017 10:21 AM, Rob Herring wrote:
> Hi all,
> 
> Below is a current list of ARM boards with more than 40 dtc warnings
> when building with W=1. There's a treewide patch in flight to fix some
> unit-address warnings[1], so those aren't included here. The list is
> grouped by maintainer. AT91, Exynos, and Allwinner continue to be at
> the top of the list and have been for some time (though having
> multiple boards for an SoC can cause lots of duplicated warnings).
> 
> Please help fix these. More checks are being added[2].
> 

[...]

> 
> 52 - arch/arm/boot/dts/keystone-k2e-evm.dts
> 73 - arch/arm/boot/dts/keystone-k2l-evm.dts
> 97 - arch/arm/boot/dts/keystone-k2hk-evm.dts
> 
Nishant is going to help me to address keystone ones.

Regards,
Santosh
