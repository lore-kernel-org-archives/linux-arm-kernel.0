From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 27 Jan 2016 19:16:42 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr> <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
Message-ID: <56A9098A.5010107@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-01-16 17:55, Jean-Francois Moine wrote:
> On Wed, 27 Jan 2016 15:36:21 +0100
> Jens Kuske <jenskuske@gmail.com> wrote:
>
>> That sounds strange, 4.5-rc1 is working perfectly fine for me too.
>>
>> I doubt the patch you linked is responsible for making it work, it only
>> removes the hardcoded output-names. If your DT isn't messed up this
>> isn't relevant at all since pll8, the initial reason for this patch, is
>> only a dummy clock for now. Are you sure you are using a clean v4.5-rc1
>> without any own modifications?
>
> To be sure, I generated a pure 4.5-rc1 kernel. Same result: no UART.
> Maybe... one more information: I am using Allwinner's u-boot.

Could be that that is the culprit, why are you not using upstream u-boot?
upstream u-boot has H3 and orangepi-pc support now.

Regards,

Hans
