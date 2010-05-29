From: jamie@shareable.org (Jamie Lokier)
Date: Sat, 29 May 2010 14:51:30 +0100
Subject: [PATCH 05/25] msm: generalize clock support.
In-Reply-To: <20100527153413.GC1957@elf.ucw.cz>
References: <1273700754-10256-6-git-send-email-dwalker@codeaurora.org>
	<20100524185540.GA1292@ucw.cz>
	<20100525005115.GA7791@huya.qualcomm.com>
	<20100526173753.GD9069@elf.ucw.cz>
	<20100526185833.GA5548@huya.qualcomm.com>
	<20100527153413.GC1957@elf.ucw.cz>
Message-ID: <20100529135130.GC3106@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> On Wed 2010-05-26 18:58:33, David Brown wrote:
> > On Wed, May 26, 2010 at 07:37:54PM +0200, Pavel Machek wrote:
> > 
> > > > Um, this is a standard 3-clause BSD license.  There are nearly
> > > > 900 existing files in the kernel that have this license on them.
> > > 
> > > Are you sure? I believe that Dual GPL/BSD is ok, just BSD is not.
> > 
> > It is, according to the FSF
> > <http://www.gnu.org/licenses/license-list.html>
> 
> Not acording to kernel sources. Please make it dual GPL/BSD.

Glibc contains many source files with only a BSD license header, and
various other GPL-compatible licenses.

If it's fine for Glibc, I believe it is surely fine for Linux.

Pavel, do you mean something specific by "not according to kernel sources"?

-- Jamie
