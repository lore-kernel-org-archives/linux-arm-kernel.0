From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 7 Jul 2016 09:57:48 +0530
Subject: [RFC PATCH v2 1/9] mailbox: Add Amlogic Meson
 Message-Handling-Unit
In-Reply-To: <CAA3gFWuY78ouBwiXfcArojbc5wOBq_5AfLQTKrr-+ELYyMcmhw@mail.gmail.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <1466503374-28841-2-git-send-email-narmstrong@baylibre.com>
 <CABb+yY3HqJG2+GMWCWF9PomxobrwWGZ=TZe5NvXPcHMDdLhkcQ@mail.gmail.com>
 <CAA3gFWuY78ouBwiXfcArojbc5wOBq_5AfLQTKrr-+ELYyMcmhw@mail.gmail.com>
Message-ID: <CABb+yY2X+BTKDOb+dT4LHURCV+w+XdbTCCR+OcMKLnYoV48rsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2016 at 6:47 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 2016-07-04 17:38 GMT+02:00 Jassi Brar <jassisinghbrar@gmail.com>:
>> On Tue, Jun 21, 2016 at 3:32 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>> Add Amlogic Meson SoCs Message-Handling-Unit as mailbox controller
>>> with 2 independent channels/links to communicate with a remote processor.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/mailbox/Makefile    |   2 +
>>>  drivers/mailbox/meson_mhu.c | 199 ++++++++++++++++++++++++++++++++++++++++++++
>>>
>> Can we call it pdev_mhu.c or similar so that some other platform using
>> the MHU as a platform_device wouldn't have to embarrassingly call it
>> 'Meson's MHU'?  And also the replace meson with that prefix in the
>> code.
>
> Yes, it may deserve a more generic naming, but pdev_mhu is not good
> looking at all !
> What about platform_mhu ?
>
OK
