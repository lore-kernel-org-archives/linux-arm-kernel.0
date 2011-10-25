From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 25 Oct 2011 09:23:35 +0100
Subject: [PATCH] drivers: create a pin control subsystem v8
In-Reply-To: <20111025081719.GA4605@ponder.secretlab.ca>
References: <CACxGe6v19pZ0i-+ksYZbG2ZvGT30UkXEHTzpZMBTB4RNUV5bnA@mail.gmail.com>
	<CAKnu2MpQ8Wvd4TF8Ge=o8ACyEoaEY8TcvOSdT1w6zfYiSKFUiw@mail.gmail.com>
	<20111004203520.GK2870@ponder.secretlab.ca>
	<CAMjpGUe9abPsdWbum2MRzOV2b5_2FDqXZC-K0KThRA6MNTr4FA@mail.gmail.com>
	<CACRpkdatiBathcoo2VjKs9jHJiKC5trDCJ0bePX1q6KbrYRN-g@mail.gmail.com>
	<20111024073604.GA8708@ponder.secretlab.ca>
	<CACRpkdZ6DCeELLhiXF=oOMKB-DxeMuvbd_c6n4H1UDMhpHKZbA@mail.gmail.com>
	<20111024110518.GG8708@ponder.secretlab.ca>
	<20111025080532.GI4429@atomide.com>
	<20111025081719.GA4605@ponder.secretlab.ca>
Message-ID: <20111025082334.GA21616@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 10:17:19AM +0200, Grant Likely wrote:

> I've got no issue with a debugfs interface, although it would probably
> a good idea to put a big scary warning into klog when userspace starts
> manipulating pinctrl setting.  Maybe should taint the kernel too.

Yes, we really should taint the kernel for any non-mediated interface -
never mind instability this stuff can cause physical damage if you get
it wrong.
