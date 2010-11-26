From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Nov 2010 15:00:08 -0600
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <AANLkTimkovvHzgdnGtGpTH1pz8QLi9K0-rcWVHCdMJbu@mail.gmail.com>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	<1290526740-27624-2-git-send-email-ohad@wizery.com>
	<20101126045912.GC6598@lixom.net>
	<AANLkTimkovvHzgdnGtGpTH1pz8QLi9K0-rcWVHCdMJbu@mail.gmail.com>
Message-ID: <20101126210008.GA27223@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 26, 2010 at 12:18:49AM -0700, Grant Likely wrote:
> On Thu, Nov 25, 2010 at 9:59 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Tue, Nov 23, 2010 at 05:38:57PM +0200, Ohad Ben-Cohen wrote:
> >> +#define pr_fmt(fmt) ? ?"%s: " fmt, __func__
> >
> > Not used.
> 
> pr_fmt() is a magic #define that changes the behaviour of the pr_*()
> macros.  See include/linux/kernel.h

D'oh, thanks.


-Olof
