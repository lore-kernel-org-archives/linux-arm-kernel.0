From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 10 Mar 2014 11:10:56 +0000
Subject: [PATCH 2/2] clk: shmobile: clk-mstp: add backwards comapt for
 indices field
In-Reply-To: <20140310105116.GG14999@e106331-lin.cambridge.arm.com>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <1394196400-17112-3-git-send-email-ben.dooks@codethink.co.uk>
 <20140310105116.GG14999@e106331-lin.cambridge.arm.com>
Message-ID: <531D9DC0.7020100@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/14 10:51, Mark Rutland wrote:
> On Fri, Mar 07, 2014 at 12:46:40PM +0000, Ben Dooks wrote:
>> Add comaptibiltiy for older device trees by checking to see if
>> the clock-indices property is there and falling back to the
>> older renesas,clock-indices field.
>
> Why are these two separate patches? This temporarily breaks
> compatibility.

Given I've not had time to change any of the device trees
for the renesas series it isn't currently an issue.

I left it separate to make it easier to remove once the changes
are through.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
