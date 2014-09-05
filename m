From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 5 Sep 2014 17:55:20 +0100
Subject: [PATCH v6 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
In-Reply-To: <20140905155321.GF24449@saruman.home>
References: <1409931392-22340-1-git-send-email-peter.griffin@linaro.org>
 <1409931392-22340-2-git-send-email-peter.griffin@linaro.org>
 <20140905154700.GE24449@saruman.home>
 <20140905155321.GF24449@saruman.home>
Message-ID: <20140905165520.GA25253@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Fri, 05 Sep 2014, Felipe Balbi wrote:
> > > +
> > > +	device_for_each_child(&pdev->dev, NULL, st_dwc3_remove_child);
> > 
> > same as before, of_platform_depopulate(). I can fix this one myself this
> > time.

Oh sorry, not sure what happened there, thanks for fixing it up:-)
> 
> it's in my testign/next branch, please make sure it looks alright.

Just checked and it looks good.

regards,

Peter.
