From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Sep 2012 16:00:50 +0200
Subject: [PATCH 06/19] ARM: ux500: Add nodes for the MSP into the HREF
 Device Tree
In-Reply-To: <20120914092332.GL3374@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdbs9_hLB9c7WbWeR_6+Le4Svzc9Y5wTNVebOiRDB-o33g@mail.gmail.com>
 <20120914092332.GL3374@gmail.com>
Message-ID: <CACRpkdYFWAbK0x2N-bQ8_pyUEbTpWfBd9oU3quJVmyH0beNnVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:23 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, Sep 10, 2012 at 02:53:45AM -0700, Linus Walleij wrote:
>> On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > +               msp3: msp at 80125000 {
>> > +                       status = "okay";
>> > +               };
>> >         };
>> >  };
>>
>> Does this really "enable" the MSPs as the title claims?
>
> Yes they do.
>
>> Aren's there any kind of bindings needed, not even a
>> register base?
>
> All that information is in the "disabled" node contained in .dtsi file.

Argh it's hard to read DT patches without parsing through all the
.dtsi:s in your head first ...

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
