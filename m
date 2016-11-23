From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 23 Nov 2016 10:32:20 +0100
Subject: [PATCH v2 3/3] usb: ohci-da8xx: rename driver to ohci-da8xx
In-Reply-To: <CAKXjFTME9Y+KEg21i05zP6+10tB4bW=cMbSftAbYhozEg1B8ZA@mail.gmail.com>
References: <20161103160308.29588-1-ahaslam@baylibre.com>
 <20161103160308.29588-4-ahaslam@baylibre.com>
 <CAKXjFTME9Y+KEg21i05zP6+10tB4bW=cMbSftAbYhozEg1B8ZA@mail.gmail.com>
Message-ID: <20161123093220.GA32502@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 06:10:50PM +0100, Axel Haslam wrote:
> Hi Greg,
> 
> On Thu, Nov 3, 2016 at 5:03 PM, Axel Haslam <ahaslam@baylibre.com> wrote:
> > The davinci ohci driver name (currently "ohci") is too generic.
> > To be consistent with other usb dirvers, append the "-da8xx" postfix
> > to the name.
> >
> 
> if there are no objections, would it be possible to pick up this patch?
> the corresponding phy patch was merged and the platform changes
> are ack'ed, and will we taken by the davinci maintainer once this patch
> gets in.

Now applied.

thanks,

greg k-h
