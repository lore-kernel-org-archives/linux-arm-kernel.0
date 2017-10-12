From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 12 Oct 2017 22:54:50 +0530
Subject: [PATCH v8 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <20171012152402.GC5614@arm.com>
References: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
 <20171012152402.GC5614@arm.com>
Message-ID: <CAKTKpr6RCzq3QhgptZECZG=YoEmTWCEhM2QaHpzx-ZEtactbHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 8:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Oct 12, 2017 at 07:41:12PM +0530, Ganapatrao Kulkarni wrote:
>> Extending json/jevent framework for parsing arm64 event files.
>> Adding jevents for ThunderX2 implementation defined PMU events.
>>
>> v8:
>>    - Rename thunderx2 directory to cavium
>
> For the series:
>
> Acked-by: Will Deacon <will.deacon@arm.com>

thanks.
>
> Although note that this conflicts against a queued fix from Mark[1], so
> you'll need to rebase on top of that.

sure, will do.
may i know the branch/repo which i can rebase to?

>
> Will
>
> [1] https://patchwork.kernel.org/patch/9990237/

thanks
Ganapat
