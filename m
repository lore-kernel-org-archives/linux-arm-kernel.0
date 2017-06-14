From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 14 Jun 2017 17:15:32 +0300
Subject: [PATCH] tty/serial: remove AVR32 specific access wrappers
In-Reply-To: <20170614132723.2duxhpjq4odchcw2@piout.net>
References: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
 <CAHp75VcMrhG0K-=dtkF1T5siAAmmLYdmCxcLdo_vvH8dLjLh=A@mail.gmail.com>
 <20170614132723.2duxhpjq4odchcw2@piout.net>
Message-ID: <CAHp75Vd8osYbgxhOe3vxLFsCuDk0p+MWz+UQQWz+uX9+bvkZmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 4:27 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 14/06/2017 at 12:43:40 +0300, Andy Shevchenko wrote:
>> On Tue, Jun 13, 2017 at 11:25 PM, Alexandre Belloni
>> <alexandre.belloni@free-electrons.com> wrote:
>> > Now that AVR32 is gone, the specific wrappers for that architecture are
>> > unnecessary and will not be compiled anymore.
>> >
>>
>> Can you rebase this on top of tty-next?
>>
>> I'm pretty sure this patch will gone.
>>
>
> So you avoided most of the bikeshedding by not copying any of the
> maintainers, nice...

Wait, what? I used get_maintainer.pl script and I took its output + Greg.

-- 
With Best Regards,
Andy Shevchenko
