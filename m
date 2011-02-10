From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 10 Feb 2011 22:46:24 +0800
Subject: [PATCH]ARM: mmp: add Trizeps6 board support
In-Reply-To: <AANLkTim54zTKwhTEKF-ppq-nbtPRAYRvxH3YL0RJ4Vuc@mail.gmail.com>
References: <46685.88.65.119.194.1297295587.squirrel@88.65.119.194>
	<AANLkTikHbJ+x0nEvdXQpzADwT3XfJNqR6O_WzaEtFWnh@mail.gmail.com>
	<AANLkTin1q=KP5xmj5mzEwOfHsMf=Mz4Ts1EbpGzJPcQX@mail.gmail.com>
	<AANLkTim54zTKwhTEKF-ppq-nbtPRAYRvxH3YL0RJ4Vuc@mail.gmail.com>
Message-ID: <AANLkTi=k3D=1qwBX4E2rmo3pAun0BtBXZVG5mGwA74Y8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> AC97+UCB1400: Sound and Touchscreen is ok. The related pxa2xx-ac97 files
> have to be modified, the changes are not in this patch. If u want, i can
> patch them later too.
>

If it doesn't create a building regression, you can submit the patches
later. For completeness, you may want to do this as a whole though,
and CC Mark Brown <broonie@opensource.wolfsonmicro.com> and
Liam Girdwood <lrg@slimlogic.co.uk> for the sound related patches.

Thanks
