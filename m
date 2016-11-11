From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 11 Nov 2016 12:50:19 -0300
Subject: [RFC PATCH 6/6] [media] davinci: vpif_capture: get subdevs from DT
In-Reply-To: <dad6e38b-093b-bd36-3e0d-a0c10bddea58@xs4all.nl>
References: <20161025235536.7342-1-khilman@baylibre.com>
 <20161025235536.7342-7-khilman@baylibre.com>
 <dad6e38b-093b-bd36-3e0d-a0c10bddea58@xs4all.nl>
Message-ID: <CABxcv==ZR0=4GhXECiKtFJZ3WEY_5h-Egvs3hjBK56FiQeF6Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Nov 11, 2016 at 12:36 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 10/26/2016 01:55 AM, Kevin Hilman wrote:
>> First pass at getting subdevs from DT ports and endpoints.
>>
>> The _get_pdata() function was larely inspired by (i.e. stolen from)
>> am437x-vpfe.c
>>
>> Questions:
>> - Legacy board file passes subdev input & output routes via pdata
>>   (e.g. tvp514x svideo or composite selection.)  How is this supposed
>>   to be done via DT?
>
> We have plans to model connectors as well in the device tree, but no
> implementation exists yet. I think Laurent has some code in progress for this,
> but I may be mistaken.
>

I posted a RFC series [0] some time ago, that proposed a DT binding
for input connectors [1] using OF graphs.

I never re-spin the series because Laurent had some comments on the DT
bindings and I was waiting for a response on to my latest email [2].
So if you can comment on this and see if the DT bindings fits your,
would be very useful.

> Anyway, hard-coding it like you do now is for now the only way.
>
>         Hans
>
>>

[0]: https://www.mail-archive.com/linux-media at vger.kernel.org/msg96393.html
[1]: http://www.spinics.net/lists/linux-media/msg99421.html
[2]: http://www.spinics.net/lists/linux-media/msg99987.html

Best regards,
Javier
