From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 1 May 2013 06:30:16 -0700
Subject: [PATCH 1/7] tty: xuartps: Sort #includes alphabetically
In-Reply-To: <5180BB21.2080306@monstr.eu>
References: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
 <1367366284-28304-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130501000048.GA1840@kroah.com>
 <cbd8c55c-066b-4396-9a4b-97d58a93b573@DB8EHSMHS005.ehs.local>
 <20130501002321.GB7435@kroah.com> <5180BB21.2080306@monstr.eu>
Message-ID: <20130501133016.GA2977@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 08:50:09AM +0200, Michal Simek wrote:
> On 05/01/2013 02:23 AM, Greg Kroah-Hartman wrote:
> > On Tue, Apr 30, 2013 at 05:05:40PM -0700, S?ren Brinkmann wrote:
> >> On Tue, Apr 30, 2013 at 05:00:48PM -0700, Greg Kroah-Hartman wrote:
> >>> On Tue, Apr 30, 2013 at 04:57:58PM -0700, Soren Brinkmann wrote:
> >>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >>>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>> CC: Jiri Slaby <jslaby@suse.cz>
> >>>> CC: linux-serial at vger.kernel.org
> >>>
> >>> Why would you need/want to do this?
> >> I often come across duplicated includes. Having some kind of order helps
> >> avoiding that, imho.
> > 
> > We have a tool to handle duplicated includes, no need to put them in
> > sorted order for them to be detected.
> 
> What's the name of tool which does that?
> I have seen results from it but have never tried to find it out name and
> how to use it.

scripts/checkincludes.pl
