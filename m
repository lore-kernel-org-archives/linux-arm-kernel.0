From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 25 Jul 2013 01:15:54 +0200
Subject: Do we have people interested in device tree janitoring / cleanup?
In-Reply-To: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
References: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
Message-ID: <1619688.mith7vb7oh@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wednesday 24 of July 2013 08:27:13 Olof Johansson wrote:
> Every now and then I come across a binding that's just done Wrong(tm),
> merged through a submaintainer tree and hasn't seen proper review --
> if it had, it wouldn't look the way it does. It's something we're
> starting to address now since there's more people stepping up to be
> maintainers, but there's a backlog of bad bindings already merged.
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

Care to explain your doubts about max8952 bindings? As far as I remember 
it's just a standard single voltage regulator (= generic regulator 
bindings) + some device specific properties.

Looking at Documentation/devicetree/bindings/regulator/max8952.txt I don't 
really see anything worrying...

Best regards,
Tomasz
