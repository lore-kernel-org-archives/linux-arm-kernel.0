From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 6 Nov 2018 07:46:55 +0100
Subject: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
In-Reply-To: <20181105204322.GE26868@zn.tnic>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
 <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
 <20181105194721.GB26868@zn.tnic>
 <CAOesGMjsPWeRZEeBH37uLQFBKwAWNMh5yCvuKNYrOUDfRSSYog@mail.gmail.com>
 <20181105204322.GE26868@zn.tnic>
Message-ID: <38dc38b6-25f4-194c-9ba9-577d35e92700@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05. 11. 18 21:43, Borislav Petkov wrote:
> On Mon, Nov 05, 2018 at 12:38:05PM -0800, Olof Johansson wrote:
>> Yeah, that's the way we've been trying to do for various subsystems
>> and it's been working pretty well. Of course, if there's need to
>> coordinate more closely for something in the future we'll be happy to
>> do so.
> 
> Goodie. Let's do that for now and we can always revisit when there's
> real need.

I think Boris should take also this one (dt binding doc change) because
it is aligned with changes in the driver.
https://lkml.kernel.org/r/1538667328-9465-7-git-send-email-manish.narani at xilinx.com

And I will take this one.
https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-manish.narani at xilinx.com

But not a problem with taking both if you like but this make more sense
to me.

Thanks,
Michal
