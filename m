From: vitalywool@gmail.com (Vitaly Wool)
Date: Wed, 15 Sep 2010 10:27:00 +0200
Subject: [PATCH v5 3/7] wireless: wl12xx: add platform data passing support
In-Reply-To: <AANLkTinM8vY7CygEN6DBR35WLkU-QOBwuiaRrpfwF6Mz@mail.gmail.com>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
	<1283376410-9999-4-git-send-email-ohad@wizery.com>
	<AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
	<20100906120716.GE20903@n2100.arm.linux.org.uk>
	<AANLkTikAFCd+3ggZKhQXY=+bG==KgLkv3qNVdEGa=GBX@mail.gmail.com>
	<AANLkTinM8vY7CygEN6DBR35WLkU-QOBwuiaRrpfwF6Mz@mail.gmail.com>
Message-ID: <AANLkTikSP874gnsPrc_M1LJYNpjX+Lz3-5=Bk5_HtgP+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/15 Ohad Ben-Cohen <ohad@wizery.com>:
>> Sorry for pushing at this, but why would you mark data that's meant to
>> be used after init phase as __initdata?
>
> I can remove the first copying as well if Russell is ok with it.

I personally think it's not worth it. This copying basically happens
only once and this point is soooo irrelevant. My position therefore
is: let's get the current implementation in, and if Michal is
uncomfortable with that, he can come up with the patch. Let's
concentrate on the real problems.

Thanks,
   Vitaly
