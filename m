From: olof@lixom.net (Olof Johansson)
Date: Fri, 8 Jun 2012 01:21:33 -0700
Subject: [PATCH v2] ARM: highbank: Add smc calls to enable/disable the L2
In-Reply-To: <4FD1486E.9080409@gmail.com>
References: <1338865900-11373-1-git-send-email-robherring2@gmail.com>
 <1339021210-25970-1-git-send-email-robherring2@gmail.com>
 <4FD1486E.9080409@gmail.com>
Message-ID: <CAOesGMihdBbVm7=zDNVCvvX9jUuBVTfcYYctokjez-MuBU0F4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 5:33 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 06/06/2012 05:20 PM, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Linux runs in non-secure mode on highbank, so we need secure monitor calls
>> to enable and disable the PL310. Rather than invent new smc calls, the same
>> calling convention used by OMAP is used here.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>
> Arnd, Olof,
>
> Can you apply this fix for 3.5. It's needed to enable the L2 on highbank.

If we were to split hairs, this is a feature addition and not a
bugfix, so as such it belongs in the next merge window. But I applied
it anyway, it's well-contained in your platform and we're early in the
-rc cycle.


-Olof
