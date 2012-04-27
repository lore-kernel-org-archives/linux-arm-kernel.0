From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 20:17:26 -0600
Subject: [PATCH 1/2] pinctrl: support gpio request deferred probing
In-Reply-To: <CACRpkdadLsqpb=X+BmomyRywf=SrgGpbW2B=Myo3zTn_xMHJ2g@mail.gmail.com>
References: <1335353894-22096-1-git-send-email-b29396@freescale.com>
 <CACRpkdadLsqpb=X+BmomyRywf=SrgGpbW2B=Myo3zTn_xMHJ2g@mail.gmail.com>
Message-ID: <4F9A01B6.2050502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2012 03:36 PM, Linus Walleij wrote:
> On Wed, Apr 25, 2012 at 1:38 PM, Dong Aisheng <b29396@freescale.com> wrote:
> 
>> From: Dong Aisheng <dong.aisheng@linaro.org>
>>
>> As pinctrl handles, it may be possible the pinctrl gpio ranges
>> are still not got registered when user call pinctrl_gpio_request.
>> Thus, add defer support for it too.
>>
>> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Since nobody is saying anything and it looks reasonable,
> I just applied this.

I didn't look at this, because V4 was sent without this patch, so I
assumed it'd been dropped by Dong. Was I wrong?
