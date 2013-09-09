From: ddaney.cavm@gmail.com (David Daney)
Date: Mon, 09 Sep 2013 15:40:19 -0700
Subject: [PATCH 2/5] ARM64: Move some signal code to a seperate file to
 be reused by ILP32.
In-Reply-To: <CA+=Sn1mj1c_k=-++K1jqU1DnYe0sUspbsuP0MMyWx+J-+JZfcw@mail.gmail.com>
References: <1378762380-13152-1-git-send-email-apinski@cavium.com>
 <1378762380-13152-2-git-send-email-apinski@cavium.com>
 <CA+=Sn1mj1c_k=-++K1jqU1DnYe0sUspbsuP0MMyWx+J-+JZfcw@mail.gmail.com>
Message-ID: <522E4E53.8060308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2013 02:38 PM, Andrew Pinski wrote:
> On Mon, Sep 9, 2013 at 2:32 PM, Andrew Pinski <pinskia@gmail.com> wrote:
>> Since the ILP32 ABI uses similar signal code as the LP64 ABI, it makes sense to reuse rather
>> than copy the same code.
>
> I just noticed that signal_template.c was not part of this patch but
> it is included with patch number 5.
>

At a minimum, the patch set should be respun so that it builds, runs and 
has no unusable Kconfig options at all intermediate points in the set.

You could also consider splitting out cosmetic changes unrelated to the 
meat of a change to a separate patches.


David Daney
