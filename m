From: alanbutty12@gmail.com (Alan M Butler)
Date: Mon, 20 Aug 2012 09:41:20 +0100
Subject: [PATCH] ARM: Kirkwood: Iomega IX2-200 Device Tree Support Patch
 v2 Signed-off-by: Alan M Butler <alanbutty12@gmail.com>
In-Reply-To: <CAOMZO5AZZwQS8rkvrG3Nd7KAhgh3+PcfkdoKiqRW95eaUyTghg@mail.gmail.com>
References: <cover.1345196553.git.alanbutty12@gmail.com>
 <05c3c186d3675cde472bcc3a01198b6726c48a3c.1345196553.git.alanbutty12@gmail.com>
 <20120819020607.GZ22226@titan.lakedaemon.net>
 <CADhrpJ5WX-ZR3vxwe92Rg4R9a1+79Vf-QxKdJhyaC87o8HJYrw@mail.gmail.com>
 <CADhrpJ6HmUd86zx6Az0bx9JiiYp6kMmTis6ARMWBrNqoK8aKng@mail.gmail.com>
 <CAOMZO5AZZwQS8rkvrG3Nd7KAhgh3+PcfkdoKiqRW95eaUyTghg@mail.gmail.com>
Message-ID: <CADhrpJ7ZE=L25V8sKyQAT02iDuyCRwyCAjw4ukopek1i0TRqNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2012 03:31, Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, Aug 19, 2012 at 3:03 PM, Alan M Butler <alanbutty12@gmail.com> wrote:
>> i just thaught i should let fabio and jason know that i just tried
>> kernel 3.6-rc2 and the buttons work i tried to apply the patch that
>> fabio sent me before but it didnt apply so i tried the kernel anyway
>> and the buttons do work.
>
> The patch I sent applies against linux-next.
>
> If you try linux-next you will probably get the kernel crash.

Oh yeah i did send you the eroor before i did try the patch on linux
next dated the 17th and the kernel did not crash but i got an error so
i will re-send you the error i got again incase you have lost it or
anything.

> orion_gpio_is_valid: invalid GPIO 0
> orion_gpio_is_valid: invalid GPIO 0
> gpio-keys gpio-keys.2: \x013INFO: %s in %pS age=%lu cpu=%u pid=%d
> Failed to request GPIO 0, error -22
> gpio-keys: probe of gpio-keys.2 failed with error -22

Thats what i got on that linux-next. but the 3.6-rc2 works fine. the
gpio settings are the exact same in the rc2 that i tried in the linux
next so it might be something in the way the dts file is read in the
new code?

should the gpio-keys be named button at 1 and so on as i see that in the
other kirkwood dts files where i have mine named power, otb, reset?
