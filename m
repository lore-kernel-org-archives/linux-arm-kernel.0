From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Fri, 24 Apr 2015 10:54:29 +0200
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <20150423102542.GZ4027@n2100.arm.linux.org.uk>
References: <5522BEEF.2000405@gmail.com> <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
 <20150408230658.GO4027@n2100.arm.linux.org.uk>
 <20150409134843.GQ4027@n2100.arm.linux.org.uk>
 <20150415163108.GB2033@earth> <20150416160858.GH18048@atomide.com>
 <20150417184156.GA3326@earth> <20150420234032.GM18048@atomide.com>
 <20150423102542.GZ4027@n2100.arm.linux.org.uk>
Message-ID: <CAALWOA_3wfn=K3qt9MzWYXMGTM7mZvqY03Biqk5T2wVF4uMVxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2015 at 12:25, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> And you can't detect whether you're running in secure mode or not.

If not, you get an undefined instruction exception, which you could trap.

This may not be convenient, but "can't detect" is an overstatement.

Matthijs
