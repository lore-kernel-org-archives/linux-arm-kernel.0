From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Aug 2013 20:24:32 +0200
Subject: [PATCH v5] gpio: pcf857x: Add OF support
In-Reply-To: <7583101.2yAsZLOucV@avalon>
References: <1377590559-14279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2400176.9Vcd5TUYl9@avalon> <20130827171854.GA2988@katana>
 <7583101.2yAsZLOucV@avalon>
Message-ID: <CACRpkda=pZ6xQ2XJke=MBLiH_DAS8CXW+JOZ856ohGZi+fOCzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 1:58 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 27 August 2013 19:18:55 Wolfram Sang wrote:
>> > The driver should support the same chip models reardless of whether it's
>> > used with or without DT. If an entry in the OF table has no corresponding
>> > entry in the I2C table I would consider that as a driver bug.
>>
>> Linus Walleij posted a patch to support DT only probing, but too many
>> side-effects showed up. Some were fixable (probe regressions) and some
>> need more work, if feasible at all. Most prominent is that runtime
>> instantiation of i2c slaves currently needs an entry in the i2c table.
>
> Linus, I'd like to get this in v3.12 if it's not too late. Could you please
> provide your input ?

Provided some input on the v4 version, due to being a bit overloaded
my patch queue is overloaded...

Yours,
Linus Walleij
