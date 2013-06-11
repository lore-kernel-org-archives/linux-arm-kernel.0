From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 11 Jun 2013 15:39:34 +0300
Subject: [PATCH v3 1/7] clk: divider: add flag to limit possible dividers
 to even numbers
In-Reply-To: <CAHp75VeQOSns1nL7p+rU1TS2stPuWibFtN_K9mFvzuGW+3WqOA@mail.gmail.com>
References: <201306111328.52679.heiko@sntech.de>
 <201306111329.32749.heiko@sntech.de>
 <CAHp75VcaNkPeUQ=OPY5F7Mqb_cM87xh8A8wUxdCgnRtfjoqoHw@mail.gmail.com>
 <201306111406.14850.heiko@sntech.de>
 <CAHp75VeQOSns1nL7p+rU1TS2stPuWibFtN_K9mFvzuGW+3WqOA@mail.gmail.com>
Message-ID: <CAHp75Vd4yXqRM9Cm=Eiv6XVZUuUC1_CaT3Ad=Eu=2qeA8bwOAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 3:37 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 11, 2013 at 3:06 PM, Heiko St?bner <heiko@sntech.de> wrote:
>> Am Dienstag, 11. Juni 2013, 13:51:56 schrieb Andy Shevchenko:
>>> On Tue, Jun 11, 2013 at 2:29 PM, Heiko St?bner <heiko@sntech.de> wrote:

> This variant I think fits:
>
> if (!(divider->flags & CLK_DIVIDER_EVEN))

Oops, without "!()" of course.

>   return div < 2 || div % 2 == 0;
>
> You check for feature and do accordingly.


--
With Best Regards,
Andy Shevchenko
