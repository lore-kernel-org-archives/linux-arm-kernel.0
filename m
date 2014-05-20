From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 22:57:41 -0700
Subject: [PATCH] ARM: edma: Clean up and simplify the code around irq
 request
In-Reply-To: <5374AD6D.8090002@ti.com>
References: <1399965961-23739-1-git-send-email-peter.ujfalusi@ti.com>
 <5374AD6D.8090002@ti.com>
Message-ID: <20140520055741.GR18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 05:35:01PM +0530, Sekhar Nori wrote:
> + ARM SoC team
> 
> On Tuesday 13 May 2014 12:56 PM, Peter Ujfalusi wrote:
> > Get the two interrupt line number at the same time by merging the two
> > instance of if(node){}else{} places.
> > replace the &pdev->dev with the already existing dev which makes it possible
> > to collapse lines with devm_request_irq()
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> Arnd, Olof, Kevin,
> 
> Do you mind applying this directly for v3.16? I do not have anything
> else queued ATM so not sending a pull request.

I see it was reposted today as part of a larger patch set with some
question as to what it applies to.

Sekhar, if you just have one patch for us to apply, then feel free to
resend it to use (git send-email --to=arm at kernel.org) and make it clear
(below the --- separator) that you want us to apply it directly, and
we'll be happy to do so.


-Olof
