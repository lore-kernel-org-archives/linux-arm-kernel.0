From: greg@kroah.com (Greg KH)
Date: Tue, 5 Jul 2011 09:15:58 -0700
Subject: [PATCH v5 1/1] drivers:staging:pruss: add pruss staging mfd
	driver.
In-Reply-To: <20110628210112.GA31081@kroah.com>
References: <1306827939-4133-1-git-send-email-subhasish@mistralsolutions.com>
	<1306827939-4133-2-git-send-email-subhasish@mistralsolutions.com>
	<20110628210112.GA31081@kroah.com>
Message-ID: <20110705161558.GA26309@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 02:01:12PM -0700, Greg KH wrote:
> On Tue, May 31, 2011 at 01:15:39PM +0530, Subhasish Ghosh wrote:
> > This patch adds the pruss MFD driver and associated include files.
> > For details regarding the PRUSS please refer the folowing link:
> > http://processors.wiki.ti.com/index.php/Programmable_Realtime_Unit_Subsystem
> > 
> > The rational behind the MFD driver being the fact that multiple devices can
> > be implemented on the cores independently. This is determined by the nature
> > of the program which is loaded into the PRU's instruction memory.
> > A device may be de-initialized and another loaded or two different devices
> > can be run simultaneously on the two cores.
> > It's also possible, as in our case, to implement a single device on both
> > the PRU's resulting in improved load sharing.
> > 
> > Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> 
> Please refresh my memory as to why this can't get merged into the
> "normal" part of the kernel?

Dropped from my queue due to lack of response :(

Please resend when you get the chance, and address the above comment in
your changelog entry (and in your TODO file as well.)

thanks,

greg k-h
