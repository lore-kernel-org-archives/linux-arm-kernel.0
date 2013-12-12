From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Dec 2013 11:46:10 +0000
Subject: [PATCH V7 2/2] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <CAPrCYkct6XePhYEEC=x0yNQoS-z=fcp2_WKxU1Zk0eO=9+ZaLA@mail.gmail.com>
References: <1386151791-4881-1-git-send-email-vkale@apm.com>
 <1386151791-4881-3-git-send-email-vkale@apm.com>
 <20131209165003.GJ13908@mudshark.cambridge.arm.com>
 <CAPrCYkfS9h_yoQMcrQDXpW_3FcSfiPz0aeNX+_gc=G4exSEVWg@mail.gmail.com>
 <CAPrCYkct6XePhYEEC=x0yNQoS-z=fcp2_WKxU1Zk0eO=9+ZaLA@mail.gmail.com>
Message-ID: <20131212114610.GA23971@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 06:33:59AM +0000, Vinayak Kale wrote:
> > Below fixup works fine on APM platform.
> > Do you want me to send this fixup as part of next revision of the
> > patch or will you apply it yourself? (For later case, you have my ack)
> 
> Any comments? Do I need to send the fix-up in next revision of patch?

Looks fine to me; I've folded in my changes and applied it to my aarch64
branch. I'll queue it for 3.14 when Catalin and I start putting that
together.

Will
