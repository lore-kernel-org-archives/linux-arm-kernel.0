From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 14 Oct 2015 11:20:18 +0900
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <CAGOxZ53W90Q37U+bfohpUVvXQfqa2M+R4g2T6d1SM1xRyn3V6A@mail.gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
 <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
 <561C4CEE.3050905@samsung.com>
 <CANAwSgRJ+5O-x61K9E_AxTZWQy3jJrKF5MiLtWRdUU29CCfa-Q@mail.gmail.com>
 <561C7DF1.6000609@samsung.com>
 <CANAwSgRBzFqHB98wSQnQu-ggGqRT2H6wC415wULXVhPg0uw_3A@mail.gmail.com>
 <561D9ACE.6050103@samsung.com>
 <CAGOxZ51uPkdGmCAs2Tc8_=YvkORJKdivN47vo1ZxkGQ-MY=-oQ@mail.gmail.com>
 <561DACC6.9040209@samsung.com>
 <CAGOxZ53W90Q37U+bfohpUVvXQfqa2M+R4g2T6d1SM1xRyn3V6A@mail.gmail.com>
Message-ID: <561DBBE2.8060609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.10.2015 11:13, Alim Akhtar wrote:
> On Wed, Oct 14, 2015 at 6:45 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> On 14.10.2015 10:06, Alim Akhtar wrote:
>>> +Doug
>>> Hello,
>>> AFAIR, dw_mmc host controller does support UHS-I [1], specially SDR50
>>> and SDR104 modes.
>>>
>>> [1]: http://www.spinics.net/lists/linux-mmc/msg28186.html
>>>
>>> What I remember is, one need to set "broken-cd" property also in order
>>> to make it work because of the vqmmc and vmmc connection on board. I
>>> didn't find the link right now, but you can search on the web, there
>>> was a long discussion about handling this.
>>> Have not checked it recently, so not sure if this got broken somehow.
>>>
>>
>> Please, don't top post.
>>
> I am sorry, but I didn't get this, what is the guide line here???

I mean reply inline, under the other person's quote, not above it.

And some old, really old joke:
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

:)

Best regards,
Krzysztof
