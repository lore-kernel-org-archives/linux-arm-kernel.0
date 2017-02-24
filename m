From: egtvedt@samfundet.no (Hans-Christian Noren Egtvedt)
Date: Fri, 24 Feb 2017 09:14:30 +0100
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <CACiLriSdRM4ZfoDsxFhf6ZVwAtacJOJ28M8CvOg6kC_XN0T-Mw@mail.gmail.com>
References: <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
 <20170221112720.ynehsryprhrhzjla@piout.net>
 <CAHp75VcKjYYAw8gw8yYXrd-vzZo50WOQ06AzPx+0g9Zakzjm-w@mail.gmail.com>
 <20170221162133.jch6yzpotj4s7zob@piout.net>
 <CAHp75VeB4eVuN5NMfAfQUtssuHezTyAM8FUswuR8FheUk1V-oA@mail.gmail.com>
 <CAHp75Vc54+GR99qM8vUDfQnehFx0g5q137k-w5XY3023UZyr5w@mail.gmail.com>
 <20170221171438.e5hvruoixafpcdps@piout.net>
 <CACiLriSdRM4ZfoDsxFhf6ZVwAtacJOJ28M8CvOg6kC_XN0T-Mw@mail.gmail.com>
Message-ID: <20170224081430.GB19663@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Thu 23 Feb 2017 21:18:13 -0800 or thereabout, H?vard Skinnemoen wrote:
> On Tue, Feb 21, 2017 at 9:14 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> On 21/02/2017 at 18:43:35 +0200, Andy Shevchenko wrote:

<snipp>

>> A few weeks ago, I was telling Boris to let it not build for a while and
>> then remove it. You already went out of your way to make it work. Again,
>> feel free to send a patch removing avr32. I can only see a lot of
>> benefits for the Atmel ARM SoCs and the many cleanups that will follow.
> 
> Agree, I can't help but feel that the AVR32 support is doing more harm
> than good at this point.

I also agree on this, I can relate to Nicolas (and Atmel friends) having to
always think about the less-maintained AVR32 parts when improving drivers.

>> If nobody complains about the 4.10 breakage, You'll have plenty of time
>> to remove it for 4.12
> 
> I'm fine with that, but I haven't put much effort into keeping it
> alive lately. If Hans-Christian agrees, I'm willing to post a patch to
> remove it, or ack someone else's patch.

Then lets plan this for 4.12, either you H?vard whip up a patch or I can
eventually do it.

I can push it through the linux-avr32 git tree on kernel.org.

-- 
mvh
Hans-Christian Noren Egtvedt
