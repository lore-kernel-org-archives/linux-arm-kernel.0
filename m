From: metan@ucw.cz (Cyril Hrubis)
Date: Thu, 17 Mar 2011 13:58:39 +0100
Subject: reboot/kexec in 2.6.38
In-Reply-To: <AANLkTik1CdT4k8SJop7b-MjR27RzF7a=i7WuodNKJi+J@mail.gmail.com>
References: <20110317064523.GA1995@ucw.cz>
	<AANLkTik1CdT4k8SJop7b-MjR27RzF7a=i7WuodNKJi+J@mail.gmail.com>
Message-ID: <20110317125839.GB21290@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> > I got report that ?reboot/kexec does not work in recent kernels.
> >
> > I tried both kexec and reboot in 2.6.38, and it worked ok. Maybe
> > config issue?
> 
> I think it's config issue. Never heard of this.
>

I've seen that on my zaurus a month or two ago. When kexeced to pxa-linux-2.6
then tried to kexec again. The last thing I've seen was Bye on the framebuffer
console and the machine freezed.

-- 
metan 
