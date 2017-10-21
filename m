From: jcm@redhat.com (Jon Masters)
Date: Fri, 20 Oct 2017 20:50:42 -0400
Subject: [PATCH 0/3] arm64: cpuinfo: make /proc/cpuinfo more human-readable
In-Reply-To: <d544f5a8-e6b2-f645-23cc-0d1466f49bf8@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170927103406.GC32150@leverpostej>
 <CAOZdJXUzo3JrHW1h6W3y3BnVq472NjPpaqTztzEODZnnMyvJRg@mail.gmail.com>
 <20171013142724.GA5893@leverpostej>
 <abeb1756-3635-2f86-131c-cd904731a308@redhat.com>
 <20171020161053.ujw3spzizhgu4g7b@lakrids.cambridge.arm.com>
 <d544f5a8-e6b2-f645-23cc-0d1466f49bf8@redhat.com>
Message-ID: <626f32d8-c6df-7c25-0391-f912be5665cf@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2017 01:24 PM, Jon Masters wrote:

> 1). The first thing people do when they get an Arm server is to cat
> /proc/cpuinfo. They then come complaining that it's not like x86. They
> can't get the output their looking for and this results in bug filing,
> and countless hours on phone calls discussing over and over again.
> Worse, there are some parts of the stack that really need this.

Within 6 hours of sending this, I get a ping about this week's "Works On
Arm" newsletter and...people reporting bugs with not getting CPU
capabilities in /proc/cpuinfo. This madness is going to end. Soon.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
