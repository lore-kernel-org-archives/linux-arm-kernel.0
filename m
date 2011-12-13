From: cjb@laptop.org (Chris Ball)
Date: Tue, 13 Dec 2011 12:16:19 -0500
Subject: [PATCH] mmc: mmci: Fixup handling of MCI_STARTBITERR
In-Reply-To: <CACRpkdazenok0RHQL0kXLKk2i3bcrWZ9aWDmoCGfjF6JpEoySA@mail.gmail.com>
 (Linus Walleij's message of "Fri, 11 Nov 2011 16:17:17 +0100")
References: <1320939199-30363-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdazenok0RHQL0kXLKk2i3bcrWZ9aWDmoCGfjF6JpEoySA@mail.gmail.com>
Message-ID: <m2mxawl7do.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 11 2011, Linus Walleij wrote:
>> The interrupt was previously enabled and then correctly cleared.
>> Now we also handle it correctly.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> This should also go to -stable I think?

Just to check:  should I be leaving MMCI patches for Russell to take
care of?  I don't have hardware, so this suits me fine, but MAINTAINERS
currently lists it as Orphan.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
