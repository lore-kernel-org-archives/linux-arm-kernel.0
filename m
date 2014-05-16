From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 16 May 2014 14:20:27 -0300
Subject: USB with 3.14.3 not working on Freescale i.mx6
In-Reply-To: <1400257863.657063826@f426.i.mail.ru>
References: <CACWLcfv6akXuM59m_hX-xB=iQYA4iAx7fZ0T5ZB3-7ik-1GZMw@mail.gmail.com>
 <CAOMZO5DzLBWFnOMCsz7W1DHg7g0CnZn2bxwjF6H6XVgMYmw-BQ@mail.gmail.com>
 <1400257863.657063826@f426.i.mail.ru>
Message-ID: <CAOMZO5B8NEezrUr5xr8DL1R_V8SeC=WF_eziGYHqaS8vt4sfhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 1:31 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> Fri, 16 May 2014 13:20:29 -0300 ?? Fabio Estevam <festevam@gmail.com>:
>> On Wed, May 14, 2014 at 6:17 AM, Till Klocke <till.klocke@yetu.com> wrote:
>> > Hello,
>> >
>> > Currently I am trying to get a recent and stable Linux kernel running
>> > on a Phytec PhyFlex board based on the i.mx6 processor from Freescale.
>>
>> Which dts file do you use?
>>
>> USB is functional on other mx6 boards.
>
> It's just words. Fabio, just give portion of the log (if it possible) where we
> see that USB is works with this kernel version and similar hardware.

Also tested on 3.14.4:

root at freescale /$ uname -r
3.14.4
root at freescale /$ lsusb
Bus 001 Device 002: ID 0457:0151
Bus 001 Device 001: ID 1d6b:0002

USB is working fine on this board and others, so it is 'not only
words' as you said :-)

I am not familiar with "Phytec PhyFlex board" and don't know which dts
file it uses. Also, I haven't seen any kernel logs, so it is difficult
to tell what is wrong with this hardware.
