From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 17 Sep 2014 22:11:13 +0200
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140917192259.GA18980@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <4416582.iOjLNrLDZE@vostro.rjw.lan> <20140917192259.GA18980@srcf.ucam.org>
Message-ID: <1628662.T2ReQ4irMm@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 17, 2014 08:22:59 PM Matthew Garrett wrote:
> On Wed, Sep 17, 2014 at 09:37:42PM +0200, Rafael J. Wysocki wrote:
> 
> > There are no implied IP issues with using the information there I know of and
> > if there's any fine print anywhere that may suggest so, please let me know.
> 
> Using the information should be fine, but my understanding of the UEFI 
> forum rules is that any submissions to UEFI specs must be from UEFI 
> forum members - there are concerns around accidentally including 
> patented material.

The documents in question are not regarded as UEFI specs, however.  They
are just hosted by UEFI.

> The easy way around this is just for the bindings to 
> be managed outside UEFI.

Again, there's a difference between UEFI material and the UEFI hosting
something (but not maintaining it).

In principle, the bindings could be hosted by UEFI, but maintained by
community members.

Rafael
