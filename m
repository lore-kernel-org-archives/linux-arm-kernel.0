From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sat, 3 Sep 2016 11:03:54 +0530
Subject: [PATCH v2 0/3] Add Platform MHU mailbox driver for Amlogic GXBB
In-Reply-To: <m24m5xc1v0.fsf@baylibre.com>
References: <1471515027-3543-1-git-send-email-narmstrong@baylibre.com>
 <m24m5xc1v0.fsf@baylibre.com>
Message-ID: <CABb+yY2Cq5KaCCvoJ5afsLfqc5NEoPMkaaYk9GjFO8=N80eVBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 3, 2016 at 5:04 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Jassi,
>
> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> In order to support Mailbox links for the Amlogic GXBB SoC, add a generic
>> platform MHU driver based on arm_mhu.c.
>>
>> This patchset follows a RFC thread along the GXBB SCPI support at :
>> http://lkml.kernel.org/r/1466503374-28841-1-git-send-email-narmstrong at baylibre.com
>> And specific MHU discussions at :
>> http://lkml.kernel.org/r/CABb+yY3HqJG2+GMWCWF9PomxobrwWGZ=TZe5NvXPcHMDdLhkcQ at mail.gmail.com
>>
>> Changes since v1 at http://lkml.kernel.org/r/1470732737-18391-1-git-send-email-narmstrong at baylibre.com :
>>  - Fix irq to signed to detect platform_get_irq() failures
>>  - Introduced back the secure channel
>>  - Fixed indexes
>
> How is this version looking to you?
>
> With your review/ack on the driver, I'd be happy to take it via the
> amlogic tree as there shouldn't be any conflicts with your tree.
>
I am ok with the driver, but I don't understand how it helps going via
amlogic tree. I would like to send a pull request every release ;)

cheers.
