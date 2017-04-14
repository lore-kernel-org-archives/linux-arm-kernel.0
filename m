From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 14 Apr 2017 17:19:55 +0200
Subject: [PATCH V5 2/2] thermal: broadcom: add Northstar thermal driver
In-Reply-To: <20170414151613.GA24429@localhost.localdomain>
References: <20170331201124.656-1-zajec5@gmail.com>
 <20170403154829.29780-1-zajec5@gmail.com>
 <20170403154829.29780-2-zajec5@gmail.com>
 <20170407044218.GA12447@localhost.localdomain>
 <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl>
 <20170414151613.GA24429@localhost.localdomain>
Message-ID: <CACna6rynSmGP20wSe0nUDGSYqb1N-ZbB3nZ4Jo9=v+303-qj=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 April 2017 at 17:16, Eduardo Valentin <edubezval@gmail.com> wrote:
> Hello Rafal,
>
> On Fri, Apr 14, 2017 at 02:16:36PM +0200, Rafa? Mi?ecki wrote:
>> On 04/07/2017 06:42 AM, Eduardo Valentin wrote:
>> >On Mon, Apr 03, 2017 at 05:48:29PM +0200, Rafa? Mi?ecki wrote:
>> >>From: Rafa? Mi?ecki <rafal@milecki.pl>
>> >>
>> >>Northstar is a SoC family commonly used in home routers. This commit
>> >>adds a driver for checking CPU temperature. As Northstar Plus seems to
>> >>also have this IP block this new symbol gets ARCH_BCM_IPROC dependency.
>> >>
>> >>Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>> >>Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> >
>> >If no objection, I am applying this series.
>>
>> Cool, hopefully there aren't any more objections :) Once applied should I
>> expect this in
>> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=next
>> ?
>
> They were already applied, but in my #linus branch. Now they are also in
> my #next branch. The #linus branch goes to the coming merge window. The
> #next branch goes to linux-next testing. Your change is now on
> linux-next test, kernelci testing, and for the coming merge windown.

I got it, thank you!

-- 
Rafa?
