From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 16 Apr 2014 20:56:44 +0100
Subject: [PATCH v4 21/21] misc: support for I-8024 in LP-8x4x
In-Reply-To: <9eb6a7ac-e8c0-4c05-8f8a-e047d2614cba@email.android.com>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com>
 <1397668667-27328-1-git-send-email-ynvich@gmail.com>
 <1397668667-27328-15-git-send-email-ynvich@gmail.com>
 <20140416193949.47f4ea68@alan.etchedpixels.co.uk>
 <9eb6a7ac-e8c0-4c05-8f8a-e047d2614cba@email.android.com>
Message-ID: <20140416205644.396709aa@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I've closely examined a dozen or two of drivers, but of them was close enough for I-8024 in terms of speed. Its channel takes 0.1 us to set up from kernel. Real user space programs can setup all for channels in 1 us with interface provided by this patch. That's said I don't have data on time that it takes for output to stabilize at the desired levels.
> 
> I've chosen drivers/misc as a location that looked to provide the shortest path for my driver to land. The driver needs support for the bus, and here it can be in one driver.
> 
> It would be great to have some more detailed input on this issue.

IIO is where we are trying to standardise all the industrial control
devices. There is stuff in places like misc for historical reasons.
