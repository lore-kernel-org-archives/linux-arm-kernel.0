From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 May 2018 09:35:43 -0300
Subject: [PATCH v2] ARM: dts: imx6/7: Remove unit-address from anatop
 regulators
In-Reply-To: <20180515074042.GP26863@dragon>
References: <1526304714-23821-1-git-send-email-festevam@gmail.com>
 <20180515074042.GP26863@dragon>
Message-ID: <CAOMZO5AxTjyrDeT+HvPN_4Ue8yBG0U4tnwFU5nS9zTPOwFDqAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, May 15, 2018 at 4:40 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> I'm a bit confused.  It looks that the change is just to revert commit
> 685e1321ba74 ("ARM: dts: imx6: Add unit address and reg for the anatop
> nodes").  But what about the simple_bus_reg warning the commit was
> fixing?

Yes, I don't get the original simple_bus_reg warning anymore.

I think we don't need the unit address and reg properties to the
anatop regulators.

There is already a 'anatop-reg-offset' property that indicates the
anatop register offset.

Rob, is this patch the correct solution to fix the duplicate
unit-address dtc warnings?

Thanks
