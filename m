From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Mar 2015 16:17:48 +0000
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <55084D99.7050004@arm.com>
References: <20150316004239.GE8656@n2100.arm.linux.org.uk>
 <20150316093553.GF8656@n2100.arm.linux.org.uk>
 <20150316130419.GI8656@n2100.arm.linux.org.uk>
 <55071742.6000405@arm.com>
 <20150316181634.GK8656@n2100.arm.linux.org.uk>
 <55072BF5.7030901@arm.com>
 <20150316195255.GM8656@n2100.arm.linux.org.uk>
 <550818A6.9020205@arm.com>
 <20150317153657.GY8656@n2100.arm.linux.org.uk>
 <55084D99.7050004@arm.com>
Message-ID: <20150317161748.GZ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 03:51:53PM +0000, Sudeep Holla wrote:
> That's bad. I started with 2 cycles for all(rd/wr/setup) latencies(data
> and tag ram) and narrowed down to this setting with multiple
> experiments. I did try booting 10 times each time at-least.
> 
> Since the bootmon sets 8 cycles for all the latencies, does it make
> sense to try that setting to check if the issue you are seeing is
> related to L2 latencies at all. Meanwhile I will continue my testing.

For me <2 2 1> works - so read and write latencies of 2, setup of 1.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
