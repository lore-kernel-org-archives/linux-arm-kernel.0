From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 5 Feb 2010 10:02:54 +0100
Subject: [PATCH 3/4] rtc: enable rtc in max8925
In-Reply-To: <771cded01002020623y47048ce3p87df41b35a5c4f81@mail.gmail.com>
References: <771cded01001250309x33f85bbah4db8b526f6706309@mail.gmail.com>
	<20100125122231.3d4ddc02@linux.lan.towertech.it>
	<771cded01001250355p71099663j385d25fc63a5d63d@mail.gmail.com>
	<20100129195644.GC23130@sortiz.org>
	<771cded01002020623y47048ce3p87df41b35a5c4f81@mail.gmail.com>
Message-ID: <20100205090253.GB4715@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 09:23:42AM -0500, Haojian Zhuang wrote:
> On Fri, Jan 29, 2010 at 2:56 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > Hi Haojian,
> >
> > On Mon, Jan 25, 2010 at 06:55:50AM -0500, Haojian Zhuang wrote:
> >> +struct max8925_rtc_info {
> >> + ? ? struct rtc_device ? ? ? *rtc_dev;
> >> + ? ? struct max8925_chip ? ? *chip;
> >> + ? ? struct i2c_client ? ? ? *i2c;
> > I dont think you need this pointer here, right ?
> >
> Yes, this unused pointer should be removed. The refreshed patch is in
> another mail loop.
Alessandro, Haojian is talking about the patch below. Does it look fine to you
?
