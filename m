From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 14 Sep 2012 06:36:35 -0700
Subject: [PATCH] staging: ste_rmi4: remove gpio.h include
In-Reply-To: <505322FD.1040802@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <1347541643-30665-1-git-send-email-robherring2@gmail.com>
 <5051E056.4060304@gmail.com> <20120914032716.GA10126@kroah.com>
 <505322FD.1040802@gmail.com>
Message-ID: <20120914133635.GA20185@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 07:28:45AM -0500, Rob Herring wrote:
> On 09/13/2012 10:27 PM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 13, 2012 at 08:32:06AM -0500, Rob Herring wrote:
> >> Adding Greg KH's correct email...
> >>
> >> On 09/13/2012 08:07 AM, Rob Herring wrote:
> >>> From: Rob Herring <rob.herring@calxeda.com>
> >>>
> >>> gpio.h is not needed and is going to be removed.
> > 
> > Care to send it to me in a format I can apply it in?
> 
> As I mentioned, this should go in via the arm-soc tree with rest of the
> gpio clean-up, so I just need an ack.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
