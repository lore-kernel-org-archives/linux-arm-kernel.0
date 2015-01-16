From: jcm@redhat.com (Jon Masters)
Date: Thu, 15 Jan 2015 22:18:26 -0500
Subject: SPCR table parsing
In-Reply-To: <54B880B5.6010907@redhat.com>
References: <54B880B5.6010907@redhat.com>
Message-ID: <54B88302.2070903@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 10:08 PM, Jon Masters wrote:

> We're implementing support for SPCR table parsing shortly[0], since it
> will allow to deprecate supplying a "console=" (and eventually, also
> "earlycon=") on 64-bit ARM servers, where it's not always the case that
> we can assume a 16550 at a specific address. SPCR has been provided on
> x86 systems since 2000 but is not (yet) supported by Linux.
> 
> If anyone knows of existing efforts on e.g. x86 or IA64, please get in
> touch. I expect the initial implementation to require revision 2+ modern
> server systems and possibly be limited to ARM initially.

Side note: I preemptively had this added to the SBBR so it's already
required on ARM servers, and have confirmed the reference systems out
there have valid tables for us to use ahead of time.

Jon.
