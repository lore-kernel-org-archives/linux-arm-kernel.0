From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 21 Aug 2013 10:05:56 +0100
Subject: [PATCH 0/3] ARM: vexpress_defconfig: Allow to boot using a
 regular filesystem on SD card
In-Reply-To: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
Message-ID: <1377075956.3591.23.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-21 at 00:02 +0300, Fathi Boudra wrote:
> vexpress_defconfig is known broken on some use-cases. This serie of
> patches allow to boot test Versatile Express using a regular filesystem
> on SD card.
> 
> Fathi Boudra (3):
>   ARM: vexpress_defconfig: Enable and automount devtmpfs filesystem
>   ARM: vexpress_defconfig: Enable voltage regulator support
>   ARM: vexpress_defconfig: Enable ext4 filesystem
> 
>  arch/arm/configs/vexpress_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)

One good question is who do you have to convince to get these changes
accepted (or rejected)?

The original config was added by Linus Walleij through Russell's tree
(who is the maintainer according to get_maintainer.pl), and as of late,
Pawel Moll seems to have been acting a vexpress maintainer. I've added
those names to the CC list.

I suspect that nobody really cases that much, but it would be good to
get some feedback or if there is silence, just ask the armsoc people to
take the changes?

-- 
Tixy
