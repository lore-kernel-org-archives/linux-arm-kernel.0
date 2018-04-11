From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Apr 2018 10:51:29 +0200
Subject: [PATCH] MAINTAINERS: Update ASPEED entry with details
In-Reply-To: <CACPK8XeD354AGXVunToR=RGQuSKWZ8vKSXH+DZey+udEE-Am_A@mail.gmail.com>
References: <20180222050324.21531-1-joel@jms.id.au>
 <CACPK8XeD354AGXVunToR=RGQuSKWZ8vKSXH+DZey+udEE-Am_A@mail.gmail.com>
Message-ID: <CAK8P3a146q8+Y0XKsPUD7ZW4qHoUetpkupfqVOWPxBi6ruwQSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
> Hey Arnd,
>
> On 22 February 2018 at 15:33, Joel Stanley <joel@jms.id.au> wrote:
>> I am interested in all ASPEED drivers, and the previous match wasn't
>> grabbing files in nested directories. Use N instead.
>>
>> Add the arm kernel mailing list so that patches get reviewed there, and
>> the linux-aspeed list which exists only so I can use patchwork to track
>> patches.
>>
>> Add Andrew as a reviewer, because he is involved in reviewing ASPEED
>> stuff.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> can you please pick this one up? It would be great to get it into
> fixes as Andrew and I have been missing being cc'd on stuff we would
> have like to review.

Sure, applied to the fixes branch now.

In general, when you want a patch to be applied, please send it to
arm at kernel.org so we know it's for us. As a rule, I don't pick up patches
otherwise but assume that you are asking for feedback and/or Acks
but will resend it once everyone is happy with the change.

      Arnd
