From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 30 Apr 2013 17:23:21 -0700
Subject: [PATCH 1/7] tty: xuartps: Sort #includes alphabetically
In-Reply-To: <cbd8c55c-066b-4396-9a4b-97d58a93b573@DB8EHSMHS005.ehs.local>
References: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
 <1367366284-28304-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130501000048.GA1840@kroah.com>
 <cbd8c55c-066b-4396-9a4b-97d58a93b573@DB8EHSMHS005.ehs.local>
Message-ID: <20130501002321.GB7435@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 05:05:40PM -0700, S?ren Brinkmann wrote:
> On Tue, Apr 30, 2013 at 05:00:48PM -0700, Greg Kroah-Hartman wrote:
> > On Tue, Apr 30, 2013 at 04:57:58PM -0700, Soren Brinkmann wrote:
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > CC: Jiri Slaby <jslaby@suse.cz>
> > > CC: linux-serial at vger.kernel.org
> > 
> > Why would you need/want to do this?
> I often come across duplicated includes. Having some kind of order helps
> avoiding that, imho.

We have a tool to handle duplicated includes, no need to put them in
sorted order for them to be detected.

thanks,

greg k-h
