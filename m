From: davidb@codeaurora.org (David Brown)
Date: Fri, 28 May 2010 10:56:13 -0700
Subject: [PATCH 05/25] msm: generalize clock support.
In-Reply-To: <20100527153413.GC1957@elf.ucw.cz>
References: <> <1273700754-10256-6-git-send-email-dwalker@codeaurora.org>
	<20100524185540.GA1292@ucw.cz>
	<20100525005115.GA7791@huya.qualcomm.com>
	<20100526173753.GD9069@elf.ucw.cz>
	<20100526185833.GA5548@huya.qualcomm.com>
	<20100527153413.GC1957@elf.ucw.cz>
Message-ID: <20100528175613.GA5455@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 05:34:14PM +0200, Pavel Machek wrote:

> > > Are you sure? I believe that Dual GPL/BSD is ok, just BSD is not.
> > 
> > It is, according to the FSF
> > <http://www.gnu.org/licenses/license-list.html>
> 
> Not acording to kernel sources. Please make it dual GPL/BSD.

If this is actually necessary, we can go back and wrangle another
license change, but it is a fairly painful and unpleasant
process.

We changed to this license initially because of an objection to
a dual license (admittedly a poorly worded one).

The BSD license is compatible with the GPL, and it should not be
necessary to add any kind of dual license to it.

David
