From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Feb 2013 09:42:01 +0100
Subject: [GIT PULL] Nomadik devicetree and cleanups
In-Reply-To: <20130131232015.GA3314@quad.lixom.net>
References: <CACRpkdZM8+6QaGrRtCCMWoZQO23uej7JDr1xz2zG7TtwQ7Ngqw@mail.gmail.com>
 <20130128213135.GA3047@quad.lixom.net>
 <CACRpkdaHo_xLwqUDF9C71HbuGEcJHg_Jrsf0gCSPYXa4E+yJGA@mail.gmail.com>
 <20130129173641.GA17935@quad.lixom.net>
 <CACRpkdaVOV4d9xeuKnMyfGgM+Su3M6dmo2pyeEQE9Qb2sErzzA@mail.gmail.com>
 <20130131232015.GA3314@quad.lixom.net>
Message-ID: <CACRpkdYyUeqcST0n20az4otfLfqoFNNibWgk-i7p=AcNCA+Qzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 1, 2013 at 12:20 AM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jan 30, 2013 at 11:21:06PM +0100, Linus Walleij wrote:
>> So as I heard this blew up for selecting OF instead of USE_OF here
>> is yet another pull request, with this oneliner change in the relevant
>> patch ("ARM: nomadik: delete old board files"):
>>
>> - select OF
>> + select USE_OF
>>
>> I have tried to provoke builderrors with the defconfig but couldn't.
>>
>> Here is then yet another pull request, and let's hope it works this
>> time around:
>
> Dropping and replacing branches is awkward, and you rewrote history here. It'd
> be better to just take a fixup patch on top that switches the two selects.

Sure, I'll fix...

Yours,
Linus Walleij
