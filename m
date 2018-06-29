From: peda@axentia.se (Peter Rosin)
Date: Fri, 29 Jun 2018 07:09:59 +0200
Subject: [PATCH v2 0/6] Add Actions Semi S900 I2C support
In-Reply-To: <20180629044439.GA29931@Mani-XPS-13-9360>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <76F2EEF1-A266-4E05-8C72-74492928A531@axentia.se>
 <20180629044439.GA29931@Mani-XPS-13-9360>
Message-ID: <565B1582-69F8-450E-8A4C-2BD528E9F07D@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On June 29, 2018 6:44:39 AM GMT+02:00, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
>Hi Peter,
>
>On Fri, Jun 29, 2018 at 06:13:31AM +0200, Peter Rosin wrote:

>> Hi!
>> 
>> I don't know for sure, but over here the arch/arm64/boot/dts/actions
>folder has no pinctrl nodes at all (v4.18-rc2). So, what is this series
>based on? The reason I started looking was that patch 2 *appears* to
>depend on patch 3, and I just wanted to double check that...
>> 
>
>You are right. The pinctrl patch [1] is still not merged by the
>platform
>maintainer Andreas but it has been reviewed by the pinctrl maintainer
>Linus Walleij. For your reference, I have queued up all reviewed dts
>patches
>in my tree [2] from which Andreas is picking them for 4.19.

Would have been helpful if this was mentioned from the start, and as I suspected, patch 3 does indeed depend on patch 2.

>For this series, since the dts patches will go through the ARM SoC
>tree,
>Andreas will pick it up once it is reviewed.
>
>Hope this clarifies!

Yup.

Cheers,
Peter

>Thanks,
>Mani
>
>[1] https://patchwork.kernel.org/patch/10322937/
>[2]
>https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next
>
>> Cheers,
>> Peter

Hi!
