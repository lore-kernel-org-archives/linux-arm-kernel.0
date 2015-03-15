From: bgamari.foss@gmail.com (Ben Gamari)
Date: Sun, 15 Mar 2015 00:10:41 -0400
Subject: [PATCH] PM / devfreq: remove checks for CONFIG_EXYNOS_ASV
In-Reply-To: <CAJ0PZbS_Xcu=OJuiy=xs7k_A1=ajp34KEdi4KGC3e-y8t3EUGw@mail.gmail.com>
References: <7638065.14871400820762911.JavaMail.weblogic@epml08>
 <CAJ0PZbS_Xcu=OJuiy=xs7k_A1=ajp34KEdi4KGC3e-y8t3EUGw@mail.gmail.com>
Message-ID: <878ueyaoji.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham <myungjoo.ham@samsung.com> writes:

> On Fri, May 23, 2014 at 1:52 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> On Thu, May 22, 2014 at 5:37 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>>> Checks for CONFIG_EXYNOS_ASV were added in v3.3. But the related Kconfig
>>> symbol has never been added to the tree. Remove these checks, as they
>>> always evaluate to false.
>>>
>>> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
>>
>> Thanks for pointing this out.
>>
>> ASV was supposed to be merged, but it appears it failed or never attempted.
>>
>> I will merge with the next batch (this week).
>>
>>
>> Cheers,
>> MyungJoo.
>
> Uh.. ASV itself affects the power efficiency; thus, I'd like to keep
> it alive, but not as the current form.
>
What is the current status of ASV? I've not seen any patches since this
was sent.

Cheers,

- Ben

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 472 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150315/2573aad6/attachment.sig>
