From: joshua.clayton@uniwest.com (Joshua Clayton)
Date: Wed, 18 Nov 2015 11:03:43 -0800
Subject: rtc test 2
In-Reply-To: <006901d12230$a8641180$f92c3480$@uniwest.com>
References: <2038851.J2zvFTXF8S@jclayton-pc> <3458577.MLHbIx9t1o@jclayton-pc>
 <006901d12230$a8641180$f92c3480$@uniwest.com>
Message-ID: <2089317.kdLWbOenKr@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 18, 2015 10:40:53 AM Alan Miller wrote:

> With 2 points we can generate a time per setting slope (like shown).    
> This graph point is 3 seconds out of 172800 or .000174 sec/sec.   That?s
> get us to within 4 minutes in a year so a longer test may be needed and a
> better setting passed on with an upgrade. Not sure about the math you have
> Josh ? to get parts per billion, billion should be in the denominator.
Hah. You almost got me there. Made my head spin a little.
To convert from seconds per second to parts per billion, the numerator gets multiplied by a billion. 
(technically the denominator gets multiplied too, but the billion is folded into the unit),
i.e. the billion in the denominator is implicit.

> 
> Best accuracy to graph with would use the min & max settings for 2 points
> like below ? we now have 1. Maybe the slope is negative but would still
> work if our min/max adjustments can over/under compensate.

We actually do have a second and third data point:
	the first test with Adams calculated guess
	the test with the maximum adjustsment


I will dig out the emails with those results when I have time,
and when I have recovered some from the math fatigue :)

hopefully they are linear.

-- 
Joshua Clayton
Software Engineer
UniWest
122 S. 4th Avenue
Pasco, WA 99301
(509) 544-0720
