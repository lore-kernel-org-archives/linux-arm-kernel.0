From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Apr 2012 21:20:10 +0200
Subject: [PATCH v2] plat-versatile: modernize FPGA IRQ controller
In-Reply-To: <4F8D8E0A.7040006@gmail.com>
References: <1334422936-28856-1-git-send-email-linus.walleij@linaro.org>
 <4F89EE5B.5080709@gmail.com>
 <CACRpkdZTacwxc=sn8qiKMjrCRZyymwet3cZb=OE87JkuVSj-MA@mail.gmail.com>
 <4F8D8E0A.7040006@gmail.com>
Message-ID: <CACRpkdY1V3Ge=n7MFtatFmH1Q3E1Tam7aCXvhQRKKieJqnE+Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 5:36 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 04/16/2012 02:31 PM, Linus Walleij wrote:
>> On small obstacle: the .map function does not pass the
>> void *host_data, so I worked around this by using a static
>> file-local but this is a bit ugly...
>
> You can't use domain->host_data ptr?

Oh didn't notice .. of course it work.

Sending out v3 it should be a nice piece of code.

Thanks for mentoring!

Yours,
Linus Walleij
