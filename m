From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 18 Apr 2016 15:15:55 -0500
Subject: [PATCH] Add EDAC peripheral init functions & Ethernet EDAC.
In-Reply-To: <20160418200227.GA2057@cz.tnic>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
 <20160414143501.GA25212@rob-hp-laptop>
 <20160415064042.330406ab.m.chehab@samsung.com>
 <5711087A.8050501@opensource.altera.com> <20160415214618.GB4545@cz.tnic>
 <5714EEC4.4060807@opensource.altera.com> <20160418200227.GA2057@cz.tnic>
Message-ID: <5715407B.8090506@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/18/2016 03:02 PM, Borislav Petkov wrote:
> On Mon, Apr 18, 2016 at 09:27:16AM -0500, Thor Thayer wrote:
>> We're still getting the single bit correction
>
> By that you mean, you get that by enabling ECC on the FIFO block?
>
Yes, you are correct. I'd still get the single bit correction by 
enabling ECC on the FIFO which is a win.

>> which makes the entire system more stable and the ability to see both
>> single bit errors corrected and the number of uncorrectable errors is
>> useful from a system point of view.
>
> If so, that makes sense, yes.
>
> Thanks.
>
