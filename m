From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 12 Oct 2014 16:24:55 +0200
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141012055146.GA1310@katana>
References: <20141010072439.GA1741@katana>
 <20141010083627.GL5182@n2100.arm.linux.org.uk>
 <20141010182604.GC6075@katana> <2769473.KEN6DZKnT7@wuerfel>
 <20141011165650.GA1263@katana> <20141011205527.GA30877@kroah.com>
 <20141012055146.GA1310@katana>
Message-ID: <20141012142455.GC21479@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 12, 2014 at 07:51:46AM +0200, Wolfram Sang wrote:
> 
> > I missed the one code path you pointed out, and that should be fixed,
> > but that doesn't mean that the original patch should be reverted, as it
> > is the way we want things to be, let's just fix up the bug and move on.
> 
> OK, that is a clear statement.
> 
> So, what is your opinion on the original cleanup series removing
> unnecessary '.owner = THIS_MODULE' lines in drivers? Helpful? Noise?

Helpful, please do it.  I can take it all through my driver-core tree if
you want, that might make things easier for others.

greg k-h
