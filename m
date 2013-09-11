From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 11 Sep 2013 14:47:42 +0200
Subject: [PATCH 1/4] cpufreq: cpufreq-cpu0: assign cpu_dev correctly to
 cpu0 device
In-Reply-To: <CAKohpokgVqmjNGTUOg61YQyqi1qO-9FaB8dmZqTqq2nQFynOkQ@mail.gmail.com>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <Pine.LNX.4.64.1309111005310.26942@axis700.grange>
 <CAKohpokgVqmjNGTUOg61YQyqi1qO-9FaB8dmZqTqq2nQFynOkQ@mail.gmail.com>
Message-ID: <2106241.8mK7DMLEOF@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 11, 2013 02:12:24 PM Viresh Kumar wrote:
> On 11 September 2013 13:45, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > Noone else seems to complain, but I don't think these =20, =09 etc. codes
> > have been invented on my side and I don't think they belong here. I'm
> > handling enough mails / patches daily to believe, that my mail system
> > isn't the cause of this. Could you please verify and regenerate and
> > resend? Unless I'm mistaken this looks like a corruption on your SMTP
> > side.
> 
> Its on Sudeep's side :) .. Or on ARM's side..
> Don't know why nobody else complained, Atleast people who test these
> patches (Like Shawn), must have applied them from mail.. Don't know
> why they aren't shouting :)

This looks like broken quoted-printable e-mail encoding somewhere (either
on the sending or on the receiving end).

> He mostly send pull requests to Rafael and so this wasn't a issue for
> Rafael :)

Git pulls are, well, from git, so e-mail encoding doesn't have anything to do
with them ...

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
