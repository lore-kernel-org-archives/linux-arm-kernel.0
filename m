From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 14 Dec 2011 01:26:49 +0100 (CET)
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
 online/active
In-Reply-To: <CAPz4a6BwzAmE=08pCfhK5of0vEV+uPaf8D-9U_MnW5_vAe6NFw@mail.gmail.com>
References: <20110908215314.829452535@linutronix.de>
 <CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
 <20110913133258.GA6267@n2100.arm.linux.org.uk>
 <CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
 <20110913175312.GB6267@n2100.arm.linux.org.uk>
 <20110923084001.GP17169@n2100.arm.linux.org.uk>
 <01d501cc84d6$62720890$275619b0$%kim@samsung.com>
 <alpine.LFD.2.02.1110071354310.3240@ionos>
 <CAPz4a6CkOXp6LHX2hFYVBhXWT4rhCUzLyYTLbO7g8u_jYcHt7Q@mail.gmail.com>
 <CAPz4a6C7md+k8pCz6mJtB-v_1h-faGxQZkOqU9vHUtcG-jrYVQ@mail.gmail.com>
 <4EC2DF93.2050904@codeaurora.org> <alpine.LFD.2.02.1111152259430.4902@ionos>
 <CAPz4a6BwzAmE=08pCfhK5of0vEV+uPaf8D-9U_MnW5_vAe6NFw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1112140124480.3020@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Dec 2011, Dima Zavin wrote:

> Thomas,
> 
> Did you ever get a chance to look into this further?

Yes, Peter and I are still debating the proper solution as this does
not only affect ARM. It looks like most of arch/* implementations are
hosed in one way or the other. Funny enough Peter and I put this on to
the tomorrow todo list a few hours ago.

Thanks,

	tglx
