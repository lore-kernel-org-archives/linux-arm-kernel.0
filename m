From: slash.tmp@free.fr (Mason)
Date: Fri, 15 May 2015 20:35:15 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <5555FB7F.901@free.fr>
References: <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <20150514144239.GZ2067@n2100.arm.linux.org.uk> <5555BC7E.7010601@free.fr>
 <20150515095159.GF2067@n2100.arm.linux.org.uk> <5555CC1A.5040604@free.fr>
 <20150515115852.GJ2067@n2100.arm.linux.org.uk> <5555EA68.7030006@free.fr>
 <20150515131521.GK2067@n2100.arm.linux.org.uk> <5555FB7F.901@free.fr>
Message-ID: <55563C63.8090504@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/2015 15:58, Mason wrote:

> Thanks for providing evidence that it does work. I am
> now hopeful to get it working. I'll start by applying
> my patch to a more recent kernel.

Could you provide the full output of /proc/timer_list for
the platform where TWD is running in one-shot mode?

Also what kernel version is that platform running?

Regards.
