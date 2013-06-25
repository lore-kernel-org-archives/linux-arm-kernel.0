From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 25 Jun 2013 19:08:53 +0200
Subject: [patch 1/1] imx53-qsb: enable usb power
In-Reply-To: <CAOMZO5DR6ChNwX8Kqb9mO66-M4xi1G3R8nQ=ENUwrp9k9S8vDg@mail.gmail.com>
 (Fabio Estevam's message of "Mon, 24 Jun 2013 22:40:04 -0300")
References: <20130620212939.018670789@rtp-net.org>
 <CAOMZO5Bk6hBtK1G_jGejAg2+2L+cJqTw-NebKUpVn-6XwBUWxw@mail.gmail.com>
 <CAOMZO5DR6ChNwX8Kqb9mO66-M4xi1G3R8nQ=ENUwrp9k9S8vDg@mail.gmail.com>
Message-ID: <878v1y9kyi.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> writes:

> On Mon, Jun 24, 2013 at 8:52 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Thu, Jun 20, 2013 at 6:29 PM, Arnaud Patard
>> <arnaud.patard@rtp-net.org> wrote:
>>> Enable usb power pin by using a fixed regulator. With this and the usb clock
>>> patch is making usb working on my loco.
>>>
>>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>>
>> Could you please test this against linux-next?
>>
>> It does not work for me:
>>
>> usbcore: registered new interface driver usb-storage
>> platform 53f80000.usb: Driver imx_usb requests probe deferral
>> platform 53f80200.usb: Driver imx_usb requests probe deferral
>
> Ok, got it working now, but had to do two changes:
>
> - Add a vbus-supply node for usbh1 as suggested by Sascha

How do you want to proceed ? send a patch on top of mine or send a new
patch containing my patch and this change ? ( I guess that the later
would be easier)

btw, now that it seems that some more stuff has been merged in chipidea
are in next, what about enabling the second port ?

Arnaud
