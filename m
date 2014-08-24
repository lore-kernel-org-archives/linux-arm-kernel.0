From: olof@lixom.net (Olof Johansson)
Date: Sun, 24 Aug 2014 11:32:20 -0700
Subject: [PATCH 1/2] ARM: dts: Enable PMIC interrupts on ODROID
In-Reply-To: <07e201cfbdf5$69d92770$3d8b7650$@samsung.com>
References: <1405500606-5752-1-git-send-email-drake@endlessm.com>
 <CAAObsKAokjDmpVy5cm_iFD52bCq+3jYeGDWzACsmh-JKktyjDw@mail.gmail.com>
 <53F22D1B.4010900@samsung.com> <3413299.OcpyWkc82q@amdc1032>
 <CABxcv=mkqmg_b+vwbVPAW7AaB86Fxx+LTuMSyC7L_mUy6u2+TQ@mail.gmail.com>
 <20140819201859.GA7929@localhost>
 <07e201cfbdf5$69d92770$3d8b7650$@samsung.com>
Message-ID: <CAOesGMgssUvj7WFic1uAZ6F3aqerrG9rqtOvSU3sR4J+cNLz-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 3:39 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Olof Johansson wrote:
>>
>> On Tue, Aug 19, 2014 at 12:15:41PM +0200, Javier Martinez Canillas wrote:
>> > Hello,
>> >
>> > On Tue, Aug 19, 2014 at 11:57 AM, Bartlomiej Zolnierkiewicz
>> > <b.zolnierkie@samsung.com> wrote:
>> > >
>> > > IMHO they should go to upstream ASAP as they fix the boot for
>> > > ODROID boards and they cannot break anything as they are limited
>> > > to ODROID dts files.
>> > >
>> >
>> > Agreed, this is definitely -rc material IMHO.
>>
>> Yes. Definitely.
>>
> OK, agreed. Will apply into fixes.

Hi,

I'm about to send a batch up to Linus, and this was quick to apply
myself, so I've done so -- I'm interested in keeping this hardware
working since I have it in my test setup as the only EXYNOS4 machine.


-Olof
