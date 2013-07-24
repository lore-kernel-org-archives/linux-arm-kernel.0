From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Jul 2013 08:27:13 -0700
Subject: Do we have people interested in device tree janitoring / cleanup?
Message-ID: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every now and then I come across a binding that's just done Wrong(tm),
merged through a submaintainer tree and hasn't seen proper review --
if it had, it wouldn't look the way it does. It's something we're
starting to address now since there's more people stepping up to be
maintainers, but there's a backlog of bad bindings already merged.

Often they are produced by translating the platform_data structures
directly over into device-tree properties without consideration to
describing the hardware or usual conventions, using key/value pairs
instead of boolean properties, etc.

Getting involved in cleaning up these kind of bindings is a great way
to learn "the ways of device tree" for someone that has interest in
that.

Latest find in this area is the Maxim 8925 bindings, that I came
across since they caused a compile warning on some defconfig. I'll
post a patch to address the warning but if someone else feels like
fixing the bindings on top of it that would be appreciated!


-Olof
