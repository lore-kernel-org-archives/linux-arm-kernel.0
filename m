From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Jan 2015 15:38:26 +0000
Subject: 3.18: lockdep problems in cpufreq
In-Reply-To: <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
 <20141215174336.GJ11285@n2100.arm.linux.org.uk>
 <3353119.0CuA8fKaup@vostro.rjw.lan>
 <20141215230922.GL11285@n2100.arm.linux.org.uk>
 <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
Message-ID: <20150106153825.GH12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 09:11:53AM +0530, Viresh Kumar wrote:
> On 16 December 2014 at 04:39, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Well, here's a patch which I'm running on top of 3.18 at the moment,
> > which is basically what I described in my email, and I'm running with it
> > and it is without any lockdep complaint.
> 
> We need two separate patches now, one for 3.18 and other one for 3.19-rc.
> 3.19 has see lots of changes in this particular file and so we need to
> change few things here.

I'm sorry, I don't have the bandwidth to create a patch for 3.19-rc
right now.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
