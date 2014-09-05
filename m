From: balbi@ti.com (Felipe Balbi)
Date: Fri, 5 Sep 2014 11:56:43 -0500
Subject: [PATCH v6 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
In-Reply-To: <20140905165520.GA25253@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
 <1409931392-22340-2-git-send-email-peter.griffin@linaro.org>
 <20140905154700.GE24449@saruman.home>
 <20140905155321.GF24449@saruman.home>
 <20140905165520.GA25253@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140905165642.GI24449@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 05:55:20PM +0100, Peter Griffin wrote:
> Hi Felipe,
> 
> On Fri, 05 Sep 2014, Felipe Balbi wrote:
> > > > +
> > > > +	device_for_each_child(&pdev->dev, NULL, st_dwc3_remove_child);
> > > 
> > > same as before, of_platform_depopulate(). I can fix this one myself this
> > > time.
> 
> Oh sorry, not sure what happened there, thanks for fixing it up:-)

no problem, it was small enough

> > it's in my testign/next branch, please make sure it looks alright.
> 
> Just checked and it looks good.

cool thanks, I'll run some extra build testing and move it to next
soonish.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140905/752bb85c/attachment.sig>
