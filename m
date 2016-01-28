From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 28 Jan 2016 09:15:57 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr> <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
Message-ID: <56A9CE3D.4020906@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-01-16 20:02, Jean-Francois Moine wrote:
> On Wed, 27 Jan 2016 19:16:42 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
>
>>> To be sure, I generated a pure 4.5-rc1 kernel. Same result: no UART.
>>> Maybe... one more information: I am using Allwinner's u-boot.
>>
>> Could be that that is the culprit, why are you not using upstream u-boot?
>> upstream u-boot has H3 and orangepi-pc support now.
>
> Yes, but using the upstream u-boot may hide the clock problem.

I agree that that could be the case. Would be interesting to figure out
what exactly is needed to get the upstream kernel to work properly
with allwinner's u-boot.

p.s.

Did I understand correctly that you are working on a kms (or fbdev) driver
for the H3? A fellow Dutch hacker (Jelle van der Waa, added to the Cc) is
looking into adding H3 video console support to upstream u-boot. If you
already have a lit-up display with an upstream kernel it would be great
if you could share that, even if it is still wip.

Regards,

Hans
