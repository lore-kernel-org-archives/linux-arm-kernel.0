From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 17 Sep 2014 21:37:42 +0200
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140917014410.GC31214@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
 <20140917014410.GC31214@srcf.ucam.org>
Message-ID: <4416582.iOjLNrLDZE@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 17, 2014 02:44:10 AM Matthew Garrett wrote:
> On Fri, Sep 12, 2014 at 10:00:16PM +0800, Hanjun Guo wrote:
> 
> > +Common _DSD bindings should be submitted to ASWG to be included in the
> > +document :-
> > +
> > +http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm

Well, the intention here is different.

The linked document is supposed to define the format of data to be returned
by _DSD and the one at:

http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf

does it specifically for the UUID associated with the DT bindings format.

There are no implied IP issues with using the information there I know of and
if there's any fine print anywhere that may suggest so, please let me know.

That said, those documents are not intended to be libraries of actual bindings.

A common place for the binding and a process for submitting/accepting them is
needed, but we are yet to agree on how to do that.

Rafael
