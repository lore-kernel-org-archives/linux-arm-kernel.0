From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Mar 2014 19:09:54 +0100
Subject: [GIT PULL 5/6] Samsung PM updates for v3.15
In-Reply-To: <CAOesGMiqhVk6JYhx=4446E1ZFWy7CrQNsjp8U6jf_De8FzidFw@mail.gmail.com>
References: <8259832.260591393840570438.JavaMail.weblogic@epml16>
 <20140309183523.GD22881@quad.lixom.net> <531CFA28.9020600@gmail.com>
 <CAOesGMiqhVk6JYhx=4446E1ZFWy7CrQNsjp8U6jf_De8FzidFw@mail.gmail.com>
Message-ID: <53273A72.2080402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 10.03.2014 01:08, Olof Johansson wrote:
> On Sun, Mar 9, 2014 at 4:32 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> On 09.03.2014 19:35, Olof Johansson wrote:
>>>
>>> On Mon, Mar 03, 2014 at 09:56:11AM +0000, Kukjin Kim wrote:
>>>>
>>>> The following changes since commit
>>>> 38dbfb59d1175ef458d006556061adeaa8751b72:
>>>>
>>>>     Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>     http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>>>> tags/samsung-pm-1
>>>>
>>>> for you to fetch changes up to e11d919e4aa2009077e3e4f829ff991d37adca61:
>>>>
>>>>     ARM: EXYNOS: Drop legacy Exynos4 clock suspend/resume code (2014-02-14
>>>> 08:16:01 +0900)
>>>
>>>
>>> Hi,
>>>
>>> I don't see a single cc or acked-by line from Mike Turquette here. I'll
>>> hold
>>> off until he's had a chance to take a look at these ones; I suspect
>>> they'll be
>>> fine since it's mostly code refactoring though.
>>
>>
>> I guess I should have ACKed them too, but it felt kind of strange to ACK my
>> own patches. ;)
>>
>> Anyway, for all samsung-clk patches:
>>
>> Acked-by: Tomasz Figa <t.figa@samsung.com>
>
> Yeah, self-acking doesn't make much sense. :)
>
> I'm mostly worried about patches touching other subsystems without the
> other maintainer being aware of it or having reviewed them. As I said,
> these mostly look like refactorings but it's still good habit.

May we get your ACK for this? I hope it's not too late already to have 
them merged for 3.15.

Best regards,
Tomasz
