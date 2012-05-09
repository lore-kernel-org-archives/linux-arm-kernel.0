From: olof@lixom.net (Olof Johansson)
Date: Wed, 9 May 2012 01:56:51 -0700
Subject: [GIT PULL] [for 3.5] request pull of dt on arch-mmp
In-Reply-To: <CAN1soZyvYVnN61HakQFKav-B1msY8UuVqDJso4OEe2zSaD=ruA@mail.gmail.com>
References: <CAN1soZxt6c6pTgOeZCBQ4+37hJfOwfxmCC=MAwCpOZZ1dMZ_sA@mail.gmail.com>
 <CAN1soZyvYVnN61HakQFKav-B1msY8UuVqDJso4OEe2zSaD=ruA@mail.gmail.com>
Message-ID: <CAOesGMhD480FNUa+QFC_dmxu7aP4jMt5MhfX2MzpT24=1-bqhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 6, 2012 at 8:50 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Sat, May 5, 2012 at 4:44 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> Hi Arnd & Olof,
>>
>> Please help to pull dt branch on arch-mmp git tree.
>>
>> The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:
>>
>> ?Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)
>>
> Hi Arnd & Olof,
>
> Pleae help to pull dt branch on arch-pxa git tree.
>
> Since some power patches are depend on irq driver code and it's
> changed in dt branch.
> I merged these power patches in dt branch to avoid building issue.

The way to do this is to still send two branches, one that includes
the dt code, and one that contains the power management changes but
that is based on the dt branch, and then explicitly mention in the
pull request that there is dependencies between the two.

Can you please do that, i.e. reset the dt branch back to only contain
the dt changes, and then take what is essentially this later pull and
do that as a 'pm' branch instead?


Thanks,

-Olof
