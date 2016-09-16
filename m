From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 16 Sep 2016 16:59:03 +0200
Subject: next-20160915 build: 2 failures 16 warnings (next-20160915)
In-Reply-To: <20160915154140.GM27974@sirena.org.uk>
References: <E1bkV4u-0004AY-TY@optimist> <20160915154140.GM27974@sirena.org.uk>
Message-ID: <ae530830-21c0-444a-85df-fc3ddebb7ec6@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-09-16 17:41, Mark Brown wrote:
> On Thu, Sep 15, 2016 at 12:43:41PM +0100, Build bot for Mark Brown wrote:
>
> Today's -next fails to build both arm and arm64 allmodconfigs due to:
>
>> 	arm64-allmodconfig
>> ERROR: "musb_root_disconnect" [drivers/usb/musb/sunxi.ko] undefined!
>
>> 	arm-allmodconfig
>> ERROR: "musb_root_disconnect" [drivers/usb/musb/sunxi.ko] undefined!
>
> due to 7cba17ec9adc8cf (musb: sunxi: Add support for platform_set_mode)
> which adds a call to that non-exported function to a module.

Thank you for catching / reporting this. One patch fixing this
coming up.

Regards,

Hans
