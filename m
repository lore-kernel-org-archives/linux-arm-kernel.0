From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 1 May 2013 08:39:35 -0700
Subject: [PATCH 1/7] tty: xuartps: Sort #includes alphabetically
In-Reply-To: <20130501002321.GB7435@kroah.com>
References: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
 <1367366284-28304-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130501000048.GA1840@kroah.com>
 <cbd8c55c-066b-4396-9a4b-97d58a93b573@DB8EHSMHS005.ehs.local>
 <20130501002321.GB7435@kroah.com>
Message-ID: <79ff34b1-0494-4118-a60d-cd5b536d3daa@VA3EHSMHS006.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 05:23:21PM -0700, Greg Kroah-Hartman wrote:
> On Tue, Apr 30, 2013 at 05:05:40PM -0700, S?ren Brinkmann wrote:
> > On Tue, Apr 30, 2013 at 05:00:48PM -0700, Greg Kroah-Hartman wrote:
> > > On Tue, Apr 30, 2013 at 04:57:58PM -0700, Soren Brinkmann wrote:
> > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > CC: Jiri Slaby <jslaby@suse.cz>
> > > > CC: linux-serial at vger.kernel.org
> > > 
> > > Why would you need/want to do this?
> > I often come across duplicated includes. Having some kind of order helps
> > avoiding that, imho.
> 
> We have a tool to handle duplicated includes, no need to put them in
> sorted order for them to be detected.
During conflict resolution, I find it easier when there is some order.
Anyway, consider it dropped.

	S?ren
