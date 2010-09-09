From: konkers@android.com (Erik Gilling)
Date: Thu, 9 Sep 2010 09:56:36 -0700
Subject: [PATCH 1/7] ARM: specify ZRELADDR for ARCH_TEGRA
In-Reply-To: <20100909072425.GA1828@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTi=7+TcOWu_62EWH6pwFUuizMT47tHJraaqzdJgp@mail.gmail.com>
	<20100903190155.GE17152@pengutronix.de>
	<AANLkTin2fEj2kRRoE+RSpBovApMaCKTs+DVz9wvj7M3u@mail.gmail.com>
	<20100903192329.GB29821@pengutronix.de>
	<20100908091113.GB29914@n2100.arm.linux.org.uk>
	<20100908115609.GA32659@n2100.arm.linux.org.uk>
	<20100908121634.GD1614@pengutronix.de>
	<20100908220710.GA9859@n2100.arm.linux.org.uk>
	<20100909072425.GA1828@pengutronix.de>
Message-ID: <AANLkTi=FW6=Ee6Z-suG043_wJSxBiCLsgcgYobDPVCeD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 9, 2010 at 12:24 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
>> Any ideas what needs to be fixed?
> I thought that there may be platforms that don't have a specification of
> zreladdr-y anymore in Makefile.boot. ?Maybe the Tegra-stuff that Linus
> should pull removes it. ?Other than that I'd check s3c. ?The rest should
> be OK.

The tegra patch does not remove the zreladdr-y in Makefile.boot.

-Erik
