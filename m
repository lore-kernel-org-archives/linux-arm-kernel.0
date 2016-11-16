From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 16 Nov 2016 07:53:13 +0100
Subject: [PATCH v2] staging: vc04_services: rework ioctl code path
In-Reply-To: <1479245234.28223.1.camel@crowfest.net>
References: <20161111061531.23507-1-mzoran@crowfest.net>
 <20161115095520.GA18059@kroah.com>
 <1479245234.28223.1.camel@crowfest.net>
Message-ID: <20161116065313.GA10278@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 01:27:14PM -0800, Michael Zoran wrote:
> I'll see what I can do, but since this is getting closer to the
> holidays I'm planing to spend less time on this. Perhaps someone else
> may be interested in cleaning up the ioctl path?
> 
> Since the old code uses obsolete kernel features, it's going to take
> some work to fix without adding any checkpatch.pl warnings.

When just moving code around, it's ok to keep the same warnings, they
can be fixed up correctly later on.

thanks,

greg k-h
