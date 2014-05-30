From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 30 May 2014 09:28:06 -0400
Subject: [RFC 1/2] ACPI: Add support for Platform Communication Channel
In-Reply-To: <CABb+yY0cQw3ZvkK37TkHuMdeOrxckJU-TNFsdiFzBHdUgaBxgg@mail.gmail.com>
References: <1401222599-12416-1-git-send-email-ashwin.chaugule@linaro.org>
 <1401222599-12416-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140530101704.GS5099@sirena.org.uk>
 <CABb+yY0cQw3ZvkK37TkHuMdeOrxckJU-TNFsdiFzBHdUgaBxgg@mail.gmail.com>
Message-ID: <CAJ5Y-eYmGKj3uvUwSYkJ3DBA=wS9LTgjG56XCmQWH0-Ax_gBaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 30 May 2014 09:03, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Fri, May 30, 2014 at 3:47 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, May 27, 2014 at 04:29:58PM -0400, Ashwin Chaugule wrote:
>>> ACPI 5.0a+ spec defines a generic mode of communication
>>> between the OS and a platform such as the BMC. This medium
>>> (PCC) is typically used by CPPC (ACPI CPU Performance management),
>>> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
>>> states).
>>>
>>> This patch adds initial support for PCC to be usable by the
>>> aforementioned PCC clients.
>>
>> This looks an awful lot like a mailbox - should it be integrated with
>> the mailbox system that Jassi (CCed) has been working on getting
>> upstream?  Not deleting any context for Jassi's benefit.
>>
> Yeah, the mailbox api should support PCC as such, with pcc-test.c as
> the client above and pcc.c as the controller driver below it.

Interesting. Do you have a git repo with this framework where I could
have a look?

Cheers,
Ashwin
