From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 25 Jul 2013 01:17:55 +0200
Subject: Do we have people interested in device tree janitoring / cleanup?
In-Reply-To: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
References: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
Message-ID: <20130724231755.GC29801@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 08:27:13AM -0700, Olof Johansson wrote:
> Every now and then I come across a binding that's just done Wrong(tm),
> merged through a submaintainer tree and hasn't seen proper review --
> if it had, it wouldn't look the way it does. It's something we're
> starting to address now since there's more people stepping up to be
> maintainers, but there's a backlog of bad bindings already merged.

Where is this backlog?

> 
> Often they are produced by translating the platform_data structures
> directly over into device-tree properties without consideration to
> describing the hardware or usual conventions, using key/value pairs
> instead of boolean properties, etc.
> 
> Getting involved in cleaning up these kind of bindings is a great way
> to learn "the ways of device tree" for someone that has interest in
> that.
> 
> Latest find in this area is the Maxim 8925 bindings, that I came
> across since they caused a compile warning on some defconfig. I'll
> post a patch to address the warning but if someone else feels like
> fixing the bindings on top of it that would be appreciated!
> 
> 
> -Olof
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
