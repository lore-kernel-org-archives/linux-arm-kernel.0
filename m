From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 26 Oct 2010 12:42:13 +0900
Subject: [PATCH 8/9] ARM: S5PV210: I2S: Upgrade platform device
In-Reply-To: <20101026030040.GA10200@opensource.wolfsonmicro.com>
References: <1288057274-25603-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTikk_Y-VnNKLVGmVZA4iR0+ZTE0u-Scms0TWMbhq@mail.gmail.com>
	<20101026030040.GA10200@opensource.wolfsonmicro.com>
Message-ID: <023501cb74bf$c8e61ad0$5ab25070$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Tue, Oct 26, 2010 at 11:00:34AM +0900, Kyungmin Park wrote:
> 
> > Can you unify the word iis vs. i2s? some variables use the 'iis', some
> > names use the i2s. As title is i2s. just unify the i2s?
> 
> I'd prefer I2S as well, it's vastly more common than IIS (I don't recall
> anyone except Samsung ever using that abbreviation).

Yeah, I also like I2S :-)
Maybe Jassi used original naming...

Anyway Mark, as you know we have no much time to merge for this merge
window.
So...if you don't mind, I'd like to apply current style now...then I think
we can cleanup it during -rc.

As a note, If possible, I will send pull request tonight(KST) for 37-rc1.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
