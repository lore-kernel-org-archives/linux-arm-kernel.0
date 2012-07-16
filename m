From: dsd@laptop.org (Daniel Drake)
Date: Mon, 16 Jul 2012 07:42:27 -0600
Subject: [PATCH v5] ARM: vfp: Always save VFP state in vfp_pm_suspend
In-Reply-To: <20120716113302.GG26723@mudshark.cambridge.arm.com>
References: <20120715215342.4DAB99D401E@zog.reactivated.net>
 <CAGsJ_4x5S4Aq-nJU1nyyw7E8Q82UPm0pNP-NYJ5N8aGn=nMdgw@mail.gmail.com>
 <20120716113302.GG26723@mudshark.cambridge.arm.com>
Message-ID: <CAMLZHHRp==xJmVRrr7i-U5cSkqn5FWxZOO+2bqVD1eO4BaL+Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 5:33 AM, Will Deacon <will.deacon@arm.com> wrote:
> Given that we don't do lazy saving on SMP systems, can we make this
> conditional on !SMP?

Colin pointed out in private mail that there are some other patches in
the android tree that fix this patch on SMP.

Colin, are you planning to roll them into one patch and posted a v6,
or send the SMP fixes separately?

Thanks
Daniel
