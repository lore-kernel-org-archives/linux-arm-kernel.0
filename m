From: bgat@billgatliff.com (Bill Gatliff)
Date: Tue, 02 Mar 2010 21:52:48 -0600
Subject: board/device file names, and machine names
In-Reply-To: <1267576760.8759.164.camel@c-dwalke-linux.qualcomm.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>	<20100302235137.GC29715@n2100.arm.linux.org.uk>
	<1267576760.8759.164.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4B8DDD10.4060601@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Walker wrote:
>
> I'm ok with doing renames once all the code is merged .. That's always
> been one of the options with the Google code. 
>   

No.  Please, no.

The ideal outcome is that the kernel.org code becomes the canonical
source code for the platform, i.e. the difference between kernel.org and
Google/Qualcomm-internal code is nil.  You might not ever get there, but
you pretty much close off that opportunity entirely when you start
renaming stuff.

> However, we need some future direction .. If we do a rename later on
> with the older code, then we ideally want new code to be submitted with
> appropriate names..
>   

... which requires work from all interested parties: Qualcomm, Google,
and the community.  Far less likely to happen than, say, we all learn
that "mahimahi == Nexus One" because we read it in a comment somewhere.


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
