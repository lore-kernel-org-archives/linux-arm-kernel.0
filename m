From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 30 May 2014 18:33:18 +0530
Subject: [RFC 1/2] ACPI: Add support for Platform Communication Channel
In-Reply-To: <20140530101704.GS5099@sirena.org.uk>
References: <1401222599-12416-1-git-send-email-ashwin.chaugule@linaro.org>
 <1401222599-12416-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140530101704.GS5099@sirena.org.uk>
Message-ID: <CABb+yY0cQw3ZvkK37TkHuMdeOrxckJU-TNFsdiFzBHdUgaBxgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 3:47 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 27, 2014 at 04:29:58PM -0400, Ashwin Chaugule wrote:
>> ACPI 5.0a+ spec defines a generic mode of communication
>> between the OS and a platform such as the BMC. This medium
>> (PCC) is typically used by CPPC (ACPI CPU Performance management),
>> RAS (ACPI reliability protocol) and MPST (ACPI Memory power
>> states).
>>
>> This patch adds initial support for PCC to be usable by the
>> aforementioned PCC clients.
>
> This looks an awful lot like a mailbox - should it be integrated with
> the mailbox system that Jassi (CCed) has been working on getting
> upstream?  Not deleting any context for Jassi's benefit.
>
Yeah, the mailbox api should support PCC as such, with pcc-test.c as
the client above and pcc.c as the controller driver below it.

Thanks,
Jassi
