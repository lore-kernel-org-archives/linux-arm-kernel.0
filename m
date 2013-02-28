From: robherring2@gmail.com (Rob Herring)
Date: Thu, 28 Feb 2013 09:02:59 -0600
Subject: [PATCH] arm64: add support for uart earlyprintk
In-Reply-To: <CAMwBHsbxizXxZRr0_R8gRgtB63Th0NuN8MLVre0o4ORgaFVfFQ@mail.gmail.com>
References: <1362049268-26822-1-git-send-email-apatel@apm.com>
 <512F6395.9030302@gmail.com>
 <CAMwBHsbxizXxZRr0_R8gRgtB63Th0NuN8MLVre0o4ORgaFVfFQ@mail.gmail.com>
Message-ID: <512F71A3.4090807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2013 08:11 AM, Anup Patel wrote:
> On Thu, Feb 28, 2013 at 7:33 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On 02/28/2013 05:01 AM, Anup Patel wrote:
>>> Signed-off-by: Anup Patel <apatel@apm.com>
>>> ---
>>>  arch/arm64/kernel/early_printk.c |   16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>
>>
>>> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
>>> is for the sole use of the intended recipient(s) and contains information
>>> that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries.
>>> It is to be used solely for the purpose of furthering the parties' business relationship.
>>> All unauthorized review, use, disclosure or distribution is prohibited.
>>> If you are not the intended recipient, please contact the sender by reply e-mail
>>> and destroy all copies of the original message.
>>>
>>
>> Is this patch confidential or GPL? You can't submit patches with a
>> notice like this.
>>
>> Rob
>>
> 
> No this patch is not confidential. I am sending this patch with
> appropriate permissions from APM.

The signature doesn't tell anyone that. There are several examples of
the same thing:

http://www.mail-archive.com/linux-usb at vger.kernel.org/msg11135.html
https://lkml.org/lkml/2011/4/22/147

Of course, there's probably many examples with patches accepted anyway
by less attentive maintainers.

> Actually, we at APM cannot disable this footer (which is a default
> setting) so please ignore it.

Which is one reason why people don't use their corporate email.

Rob

> 
> Regards,
> Anup
> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
> is for the sole use of the intended recipient(s) and contains information
> that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
> It is to be used solely for the purpose of furthering the parties' business relationship. 
> All unauthorized review, use, disclosure or distribution is prohibited. 
> If you are not the intended recipient, please contact the sender by reply e-mail 
> and destroy all copies of the original message.
> 
