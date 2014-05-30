From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 30 May 2014 13:32:14 -0400
Subject: [RFC 1/2] ACPI: Add support for Platform Communication Channel
In-Reply-To: <CAJe_ZhcRgrHCED-TA-NOJF6Njv-Z=ttTXO=wfn1VZjcCbiR6aA@mail.gmail.com>
References: <1401222599-12416-1-git-send-email-ashwin.chaugule@linaro.org>
 <1401222599-12416-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140530101704.GS5099@sirena.org.uk>
 <CABb+yY0cQw3ZvkK37TkHuMdeOrxckJU-TNFsdiFzBHdUgaBxgg@mail.gmail.com>
 <CAJ5Y-eYmGKj3uvUwSYkJ3DBA=wS9LTgjG56XCmQWH0-Ax_gBaQ@mail.gmail.com>
 <CAJe_ZhcRgrHCED-TA-NOJF6Njv-Z=ttTXO=wfn1VZjcCbiR6aA@mail.gmail.com>
Message-ID: <CAJ5Y-eb=9JLJn4YwDV7evYsd0FDNGu=Fj5RucjEz-PtdJVNZ+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On 30 May 2014 09:40, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>>
> Please scrape it from https://lkml.org/lkml/2014/5/15/49
> My platform also uses the doorbell mechanism with request and response
> written in shared-memory, so I am confident the mailbox api should
> work for PCC.

Just had a quick look. PCC integration appears doable and the queuing
and async notification stuff also looks useful. I'll play around with
it a bit more to see if it really works. Meanwhile, the one thing that
comes to mind is the DT bindings. For an ACPI-only kernel, we'll
probably need another function (at least) to register mbox controllers
and clients.

Cheers,
Ashwin
