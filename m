From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 2 Jun 2011 12:55:32 +0300
Subject: [PATCH 4/5] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <BANLkTikpO9VR9tqJT_bROA_KfdxOBS7U0Q@mail.gmail.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<BANLkTimC=MrmjinzufrnOMSAgiQvVKdWhA@mail.gmail.com>
	<BANLkTikpO9VR9tqJT_bROA_KfdxOBS7U0Q@mail.gmail.com>
Message-ID: <201106021255.33505.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 June 2011 12:50:56 Jassi Brar wrote:
> On Thu, Jun 2, 2011 at 3:14 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> >>> It's really unfortunate that there's no software visible method I'm
> >>> aware of :/
> >> 
> >> Unfortunately, There is no method to detect 800Mhz s3c6410 by software.
> > 
> > Then how about to introduce the software flags. and set it at each
> > board. It can support the 800MHz.
> > Also this flags are handled at cpufreq drivers properly.
> > 
> > How do you think?
> 
> Two SMDKs may have different versions of s3c6410.
> Which file do we want to set the flags in ?

What about adding cmdline arg like 's3c6410_maxfreq', and defaulting it to 667 
MHz?

Regards
Vasily
