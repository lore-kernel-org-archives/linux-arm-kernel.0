From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 2 Oct 2012 19:58:55 +0200
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <50693ECD.4000000@ti.com>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50693ECD.4000000@ti.com>
Message-ID: <20121002175854.GB2376@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 12:27:17PM +0530, Vaibhav Hiremath wrote:
> 
> As far as kernel is concerned, All the required patches have been merged
> for v3.7, so if you use linux-next/master branch, you should be able to
> boot without any issues. You just need to apply one minor patch which is
> left behind - https://patchwork.kernel.org/patch/1499411/
> 
> I have just tested it to cross-check and it boots up fine with
> linux-next/master branch. I have pasted boot log below for your reference.

Thanks, this is just the information that I was lookings for. In the
mean time I have something working based on the arago kernel, and I
will wait until 3.7-rc1 to try the vanilla kernel again.

Cheers,
Richard
