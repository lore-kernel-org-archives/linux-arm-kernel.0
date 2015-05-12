From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 12 May 2015 10:36:50 -0600
Subject: [RFC PATCH v2 0/1] ARM: cpuidle: heterogeneous systems extension
In-Reply-To: <20150422085507.GA22601@red-moon>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAMAWPa_fMhgFfL8krDxT9h42mydVogkaYQt1Me1qJTsKeH5dSA@mail.gmail.com>
 <20150422085507.GA22601@red-moon>
Message-ID: <20150512163650.GM16124@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 22 2015 at 02:55 -0600, Lorenzo Pieralisi wrote:
>On Tue, Apr 21, 2015 at 07:24:54PM +0100, Kevin Hilman wrote:
>> On Thu, Apr 16, 2015 at 9:10 AM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>
>> [...]
>>
>> > This patch sets the maximum number of static CPUidle drivers allowed to
>> > two, since it is hard to foresee systems with more than two sets of CPUs
>> > having different idle states
>>
>> It's not hard to forsee anymore:
>>
>>    http://www.cnx-software.com/2015/04/21/mediatek-helio-x20-deca-core-processor/
>>    https://liliputing.com/2015/04/closer-look-at-mediateks-upcoming-10-core-helio-x20-processor.html
>
>Eheh I stand corrected :). Not a big deal, drivers can be allocated
>dynamically; it seems that the designs above leave us no choice, the
>idle states are the only differentiating factor when it comes
>to CPUidle driver logical cpumask creation, happy to hear more
>opinions on this, but I do not really see what we can use instead.


Dynamic idle driver would be nice. Otherwise, the patch looks good to
me.

Thanks,
Lina
