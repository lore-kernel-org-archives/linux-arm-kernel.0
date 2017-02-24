From: egtvedt@samfundet.no (Hans-Christian Noren Egtvedt)
Date: Fri, 24 Feb 2017 09:52:09 +0100
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <20170224092742.3ce205e2@bbrezillon>
References: <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
 <20170221112720.ynehsryprhrhzjla@piout.net>
 <CAHp75VcKjYYAw8gw8yYXrd-vzZo50WOQ06AzPx+0g9Zakzjm-w@mail.gmail.com>
 <20170221162133.jch6yzpotj4s7zob@piout.net>
 <CAHp75VeB4eVuN5NMfAfQUtssuHezTyAM8FUswuR8FheUk1V-oA@mail.gmail.com>
 <CAHp75Vc54+GR99qM8vUDfQnehFx0g5q137k-w5XY3023UZyr5w@mail.gmail.com>
 <20170221171438.e5hvruoixafpcdps@piout.net>
 <CACiLriSdRM4ZfoDsxFhf6ZVwAtacJOJ28M8CvOg6kC_XN0T-Mw@mail.gmail.com>
 <20170224081430.GB19663@samfundet.no>
 <20170224092742.3ce205e2@bbrezillon>
Message-ID: <20170224085209.GA27812@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Fri 24 Feb 2017 09:27:42 +0100 or thereabout, Boris Brezillon wrote:
> On Fri, 24 Feb 2017 09:14:30 +0100 Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> wrote:
>> Around Thu 23 Feb 2017 21:18:13 -0800 or thereabout, H?vard Skinnemoen wrote:
>> > On Tue, Feb 21, 2017 at 9:14 AM, Alexandre Belloni
>> > <alexandre.belloni@free-electrons.com> wrote:  
>> >> On 21/02/2017 at 18:43:35 +0200, Andy Shevchenko wrote:  

<snipp>

>> >> If nobody complains about the 4.10 breakage, You'll have plenty of time
>> >> to remove it for 4.12  
>> > 
>> > I'm fine with that, but I haven't put much effort into keeping it
>> > alive lately. If Hans-Christian agrees, I'm willing to post a patch to
>> > remove it, or ack someone else's patch.  
>> 
>> Then lets plan this for 4.12, either you H?vard whip up a patch or I can
>> eventually do it.
>> 
>> I can push it through the linux-avr32 git tree on kernel.org.
>> 
> 
> Can you do that just after 4.11-rc1 is released and provide a topic
> branch I can pull in my nand/next branch, so that I can rework this
> patch and drop all the pdata-compat code (as suggested by Andy).

OK, I will try to prepare it during the weekend.

Any reason to wait for 4.11-rc1? AFAIK Linus prefers the larger changes
before he starts tagging rc's.

-- 
mvh
Hans-Christian Noren Egtvedt
