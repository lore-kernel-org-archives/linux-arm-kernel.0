From: rafael.j.wysocki@intel.com (Rafael J. Wysocki)
Date: Wed, 16 Aug 2017 19:17:30 +0200
Subject: next-20170815 build: 2 failures 4 warnings (next-20170815)
In-Reply-To: <CAMuHMdVKkROQFY-H+RamHcm_oBr10uGOD40d90MyfmdzEFRKRg@mail.gmail.com>
References: <E1dhZPk-0002d9-9k@optimist>
 <20170815111612.esq73hxowbw2mehj@sirena.org.uk>
 <13442814.gWUDHvzIl2@aspire.rjw.lan>
 <CAMuHMdVKkROQFY-H+RamHcm_oBr10uGOD40d90MyfmdzEFRKRg@mail.gmail.com>
Message-ID: <17b0fa8e-3490-0537-d0a2-fc0aaf19edea@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/16/2017 3:19 PM, Geert Uytterhoeven wrote:
> Hi Rafael,
>
> On Tue, Aug 15, 2017 at 1:59 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, August 15, 2017 1:16:12 PM CEST Mark Brown wrote:
>>> --xqegarazqzvkdxmo
>>> Content-Type: text/plain; charset=us-ascii
>>> Content-Disposition: inline
>>>
>>> On Tue, Aug 15, 2017 at 11:49:36AM +0100, Build bot for Mark Brown wrote:
>>>
>>> Today's -next fails to build on arm64 due to:
>>>
>>>>      arm64-allmodconfig
>>>>      arm64-defconfig
>>>> ../drivers/acpi/spcr.c:168:1: error: expected expression before '<<' token
>>>> ../drivers/acpi/spcr.c:198:1: error: expected expression before '>>' token
>>> caused by f69ba1326ac33b (Merge branch 'acpi-spcr' into linux-next)
>>> which has an unresolved conflict in it.
>> Yes, I broke this, sorry.
>>
>> Will fix it shortly.
> The rebased version (fix?) lacks a curly opening brace.
> Gmail-whitespace-damaged patch to fold into the bad version below.

OK, should be fixed now.

Sorry for breaking it again.

Thanks,
Rafael
