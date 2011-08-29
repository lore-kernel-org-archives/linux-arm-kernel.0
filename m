From: davej@redhat.com (Dave Jones)
Date: Mon, 29 Aug 2011 11:28:24 -0400
Subject: [PATCH v2] ARM: ux500: send cpufreq notification for all cpus
In-Reply-To: <CACRpkdakub21x+hco4+EBwLmiH9ZJsYQujsL=3m0H7g2LMFkEQ@mail.gmail.com>
References: <1314253880-2438-1-git-send-email-vincent.guittot@linaro.org>
	<CACRpkdakub21x+hco4+EBwLmiH9ZJsYQujsL=3m0H7g2LMFkEQ@mail.gmail.com>
Message-ID: <20110829152824.GA2027@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 11:44:31AM +0200, Linus Walleij wrote:
 > On Thu, Aug 25, 2011 at 8:31 AM, Vincent Guittot
 > <vincent.guittot@linaro.org> wrote:
 > 
 > > The same clock is used for all cpus so we must notify the frequency change
 > > for each one in order to update the configuration of all twd clockevents.
 > >
 > > change since V1:
 > > * use policy->cpus instead of cpu_online_mask
 > >
 > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
 > 
 > Acked-by: Linus Walleij <linus.walleij@linaro.org>
 > 
 > Dave, are you picking this up?

yeah, I have it queued. I'll get to it today.

thanks,

	Dave
