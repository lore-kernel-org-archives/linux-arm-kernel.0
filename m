From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 19:40:43 +0100
Subject: [PATCH] pinctrl: mvebu: prevent walking off the end of group array
In-Reply-To: <20130313175053.GQ12700@titan.lakedaemon.net>
References: <1362872371.3690.106.camel@shinybook.infradead.org>
 <1363196155-1620-1-git-send-email-jason@lakedaemon.net>
 <CACRpkdaoF-PqqOi3bCQXnuey_2U+niHA8RWriXiJUE=kUZB0dQ@mail.gmail.com>
 <20130313175053.GQ12700@titan.lakedaemon.net>
Message-ID: <CACRpkdamWpNpwSL1OS4TDaAfzZtKyy54VzaA2nReu3hYOcYBMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 6:50 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Mar 13, 2013 at 06:47:36PM +0100, Linus Walleij wrote:
>> On Wed, Mar 13, 2013 at 6:35 PM, Jason Cooper <jason@lakedaemon.net> wrote:
>>
>> > From: David Woodhouse <dwmw2@infradead.org>
>> >
>> > While investigating (ab)use of krealloc, David found this bug.  It's
>> > unlikely to occur, but now we detect the condition and error out
>> > appropriately.
>> >
>> > Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
>> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>> > ---
>> > David, please double check that this is as you intended.  I had to hand-jam it in due to some peculiarities on my side.
>>
>> I have tentatively applied this to my fixes branch.
>
> Dang, you're quick.  Please see V2 <shuffles feet>

Ah, I'm too trigger happy. I took it out again waiting for some ACK
and testing..

Yours,
Linus Walleij
