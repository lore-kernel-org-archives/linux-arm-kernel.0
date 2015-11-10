From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Nov 2015 09:43:28 +0100
Subject: [PATCH 1/3] mtd: create a partition type device tree binding
In-Reply-To: <20151110032626.GN12143@google.com>
References: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
 <20151029162908.GA13275@localhost>
 <CACRpkdYS5Jf8UC2K0bNdEQZDjTeZZx44Uu-kkof+9E=4Ny0oDg@mail.gmail.com>
 <20151030175145.GF13239@google.com>
 <CAL_JsqL2F3p7qBPbOiGytVyzF_aNLWbrCT0mAX1WZo6SxE3JoA@mail.gmail.com>
 <20151110032626.GN12143@google.com>
Message-ID: <CACRpkdYQWaE3+iGA-W+2koo3fZWCWyCLoqJ+FgHor-nkPmgGAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 4:26 AM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Fri, Nov 06, 2015 at 08:13:13AM -0600, Rob Herring wrote:
>> Since we now have partitions contained in a sub node, how about using
>> compatible for that sub node instead.
>
> That seems like a pretty good idea to me.

Hm! That's a clever idea. I'll take a spin on that.

Yours,
Linus Walleij
