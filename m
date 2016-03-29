From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 29 Mar 2016 18:19:56 +0200
Subject: [PATCH] MAINTAINERS: attach arch/arm/configs/mvebu_*_defconfig to
 relevant maintainers
In-Reply-To: <20160318102203.GJ1184@io.lakedaemon.net> (Jason Cooper's message
 of "Fri, 18 Mar 2016 10:22:03 +0000")
References: <1458289626-26153-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160318102203.GJ1184@io.lakedaemon.net>
Message-ID: <87d1qdw91v.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On ven., mars 18 2016, Jason Cooper <jason@lakedaemon.net> wrote:

> On Fri, Mar 18, 2016 at 09:27:06AM +0100, Thomas Petazzoni wrote:
>> The arch/arm/configs/mvebu_*_defconfig currently don't belong to any
>> maintainer, so get_maintainer returns only information based on
>> commits, which is not completely accurate.
>> 
>> Therefore, this commit replaces a useless empty newline in MAINTAINERS
>> by a line attaching those defconfigs to the appropriate Marvell EBU
>> maintainers.
>> 
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Applied on mvebu/defconfig (I just have to adapt it to fit with
v4.6-rc1)

Thanks,

Gregory


>
> thx,
>
> Jason.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
