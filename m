From: banajit.goswami@gmail.com (Banajit Goswami)
Date: Wed, 27 Jul 2011 14:26:02 +0530
Subject: [PATCH 0/8] ARM: SAMSUNG: Add common PWM Backlight support
In-Reply-To: <j0logn$1bn$1@dough.gmane.org>
References: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
	<j0logn$1bn$1@dough.gmane.org>
Message-ID: <CABK8_vRJG16jkSXOmQuDycSb6gZMHwX9vzTccaWS1-JCH1q4_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On Tue, Jul 26, 2011 at 12:27 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> On Fri, 15 Jul 2011 20:12:40 +0530, Banajit Goswami wrote:
>
>> The patches are created against "for-next" branch of Kukjin Kim's tree
>> at:
>> ?git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>>
>> ?Patch [1/8]
>> ? -- add a common infrastructure to support PWM backlight for various
>> ? ? ?Samsung boards.
>
> Why can't you use the drivers/video/backlight/pwm-bl.c ?
These patches indeed use the drivers/video/backlight/pwm-bl.c driver (do not
replace it), and provide board specific data from a common place.
The patches are meant to avoid any duplicate code which might be needed
for different Samsung boards.
>
> --
> With best wishes
> Dmitry
>
Thanks and Regards,
Banajit
