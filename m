From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Wed, 11 Aug 2010 12:11:52 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <20100811095454.GA22543@n2100.arm.linux.org.uk>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
	<20100811095454.GA22543@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimX46QKAGhiyo8AodaXVjuzoxr5-5z2V4gRr1Vu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You haven't said what HCD you're using.
>
imx21_hcd  (submitted by me and mainlined in 2.6.34)

> In that case, I'd say the HCD must handle misaligned URBs itself so
> behaviour is consistent between all implementations on different
> platforms.
>
Here is a pointer to the thread where it was stated that HCD's don't
have to handle this.

http://kerneltrap.org/mailarchive/linux-usb/2009/4/20/5528164
