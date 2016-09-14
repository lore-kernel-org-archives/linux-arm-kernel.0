From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Sep 2016 13:13:44 +0200
Subject: [PATCH 18/33] pcmcia: sa1100: provide generic CF support
In-Reply-To: <20160914090602.GB1041@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJl3-0000nS-Nw@rmk-PC.armlinux.org.uk>
 <CACRpkda7qHx4JVdVv+q3=twTup9rDD2ke8K-tSH9CkhZMQqemg@mail.gmail.com>
 <20160914090602.GB1041@n2100.armlinux.org.uk>
Message-ID: <CACRpkdZ9h=thWQeHfUs2FstEiKP1ea5MLH2eo74EuEX-PKjmSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 11:06 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Thanks, I've included a change there, should be part of the branch by
> the time you get this email - sa1100 head should be 9ad0f8181616.  If
> not, it's probably still being pushed out over my slow 'net link.

Thanks, fetched it and tested, this fix is there things work so far.

>> (It revealed another bug in fetching GPIOs but it is an orthogobal
>> problem altogether, looking into it.)
>
> If you're referring to the generic sa1100 pcmcia code, there's a fix
> for that already in my branch.

Unfortunately not, the bug is still there, I'll point it out in the relevant
patch, just need to do a boot test.

Yours,
Linus Walleij
