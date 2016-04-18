From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 18 Apr 2016 09:27:16 -0500
Subject: [PATCH] Add EDAC peripheral init functions & Ethernet EDAC.
In-Reply-To: <20160415214618.GB4545@cz.tnic>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
 <20160414143501.GA25212@rob-hp-laptop>
 <20160415064042.330406ab.m.chehab@samsung.com>
 <5711087A.8050501@opensource.altera.com> <20160415214618.GB4545@cz.tnic>
Message-ID: <5714EEC4.4060807@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 04/15/2016 04:46 PM, Borislav Petkov wrote:
> On Fri, Apr 15, 2016 at 10:27:54AM -0500, Thor Thayer wrote:
>> I'll update this patch to only count errors.
>
> ... and also think about what that counting is going to bring. If it is
> only going to be there to show how many network errors happened and we
> can't do anything about it except stare at that number, then adding all
> that code is probably waste of time an electrons...
>
> I'm just sayin'.
>

Yes, valid point about the uncorrectable errors.

We're still getting the single bit correction which makes the entire 
system more stable and the ability to see both single bit errors 
corrected and the number of uncorrectable errors is useful from a system 
point of view.
