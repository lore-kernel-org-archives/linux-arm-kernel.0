From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 13:28:52 +0200
Subject: [PATCH v6 02/18] sh-pfc: Add DT support
In-Reply-To: <1785860.1aS5315FIj@avalon>
References: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <3527983.0zjA6RU0T0@avalon> <20130617070315.GA22175@verge.net.au>
 <1785860.1aS5315FIj@avalon>
Message-ID: <CACRpkdYf36uf6xikRi=YrS03j1mENvg7OLSBxxq_XHXt8ymOOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 1:00 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 17 June 2013 16:03:16 Simon Horman wrote:
>> Hi Laurent,
>>
>> As 3.10-rc6 has been released it is probably now too late for me
>> to take this series through the renesas tree for v3.11.
>>
>> I am happy for Linus to take it if that is what he would like to do.
>
> OK.
>
> Linus, would you like to take the series through your tree, or push it back to
> v3.12 ?

Maybe a little bit of both?

I don't want to carry anything that will collide with the stuff
harvested into ARM SoC through Simon.

Can you send a small set of self-contained patches that
do not touch anything in arch/arm/* and which does not
collide with anything already queued in ARM SoC for v3.11?

In that case I'd be happy to take it as some preparation
for v3.12.

Yours,
Linus Walleij
