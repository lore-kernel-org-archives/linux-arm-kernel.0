From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 21 May 2018 09:44:20 +0300
Subject: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
In-Reply-To: <20180520192523.32dde632@xps13>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <5456625.lDWjtgZygK@z50>
 <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
 <3505791.x6nWYTo8eb@z50>
 <CAHp75Vdp5A58JMTf8vaET84QEzzZ_T7eKLUYfWV9qpWt5ptYCA@mail.gmail.com>
 <20180520192523.32dde632@xps13>
Message-ID: <CAHp75VcCVNGey1TmAR7EJ3wJL1q+KSOXpbwJ3XmoU70tKOm+Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 8:25 PM, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> On Sun, 20 May 2018 19:17:04 +0300, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

> Do we actually have the possibility to rename this gpio? I guess no
> since it would break DT backward compatibility.

No we don't.

> Otherwise it would have
> been more descriptive to call it something like 'gpio-rb'.

"gpio" prefix, actually "gpios" suffix is a mandatory part of the
name. For sake of convenience it's not used in API calls.

-- 
With Best Regards,
Andy Shevchenko
