From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 29 Jun 2016 23:14:29 +0200
Subject: [PATCH V2 4/4] ACPI,PCI,IRQ: correct operator precedence
In-Reply-To: <d22fd8f7-7028-b4b7-6677-6903685034aa@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0j+CJ3qWTdvm6Sk3DqFYVnkuEmaR1EPZM6DDVMC8rsK+g@mail.gmail.com>
 <d22fd8f7-7028-b4b7-6677-6903685034aa@codeaurora.org>
Message-ID: <CAJZ5v0h1o5C8t+QJuFo93uZt0XuPNwtXFs5XSBkhm-fARWqi2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 8:29 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 6/29/2016 9:16 AM, Rafael J. Wysocki wrote:
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Well, this is a rather obvious one, so I'm wondering why it is the
>> last one in the series?
>>
>
> The first three are more relevant to each other. It makes easy to
> correlate the changes.

But this one doesn't seem to depend on them and it could be applied
without them, right?

Thanks,
Rafael
