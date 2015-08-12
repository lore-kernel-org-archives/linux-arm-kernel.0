From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Aug 2015 10:08:57 +0100
Subject: 3.18: lockdep problems in cpufreq
In-Reply-To: <20150812081257.GC16445@linux>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
 <20150518185645.GA28053@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
 <20150812051659.GI32049@linux>
 <20150812072129.GD7557@n2100.arm.linux.org.uk>
 <20150812073530.GA16445@linux>
 <20150812074925.GG7557@n2100.arm.linux.org.uk>
 <20150812081257.GC16445@linux>
Message-ID: <20150812090857.GJ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 01:42:57PM +0530, Viresh Kumar wrote:
> On 12-08-15, 08:49, Russell King - ARM Linux wrote:
> > The problem will be back-porting it to stable kernels, because I think
> > it's had to be updated at least a couple of times.  I don't have the old
> > versions anymore, so I'm just going to say "not my problem" - sorry.
> 
> Your old 3.18 version :)

And now generate versions for all the stable kernels inbetween.  Now
your problem.  I'm sick of this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
