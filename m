From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 07 Jan 2013 14:47:58 +0100
Subject: [GIT PULL] MTU clksrc changes for v3.9
In-Reply-To: <CACRpkdY3bdsCzva0+wrFQYLK-nRtNwQ_AYOEL5rpzjZAvMmh3Q@mail.gmail.com>
References: <CACRpkdaFLNWj4qg=571K5pCrE01r6JoSOGoUvGGBOCeEW=3hYQ@mail.gmail.com>
 <CACRpkdY3bdsCzva0+wrFQYLK-nRtNwQ_AYOEL5rpzjZAvMmh3Q@mail.gmail.com>
Message-ID: <1401334.iRpc7dK4pf@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 07, 2013 11:13:53 AM Linus Walleij wrote:
> On Mon, Jan 7, 2013 at 11:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > Since there are some pending patches moving the ux500 cpufreq driver
> > around here:
> > http://marc.info/?l=linux-arm-kernel&m=135515323413100&w=2
> > it should be applied to the cpufreq tree to minimize conflicts.
> > Patches are ACKed by John Stultz.
> >
> > Please pull it into the cpufreq tree or advise on alternate path, we can
> > also take this and the other cpufreq patches through the ARM SoC
> > tree if you ACK them.
> 
> Thinking of it again I also sent out this patch messing around with the
> cpufreq driver:
> http://marc.info/?l=linux-arm-kernel&m=135754842927541&w=2
> 
> I think it may be best after all to take all of this through the ARM
> SoC tree.
> 
> But I'd like your ACKs on the CPUfreq stuff though... The patch
> here
> "cpufreq: db8500: set CPUFREQ_CONST_LOOPS",
> These five patches:
> http://marc.info/?l=linux-arm-kernel&m=135515323413100&w=2
> And the one just referenced:
> http://marc.info/?l=linux-arm-kernel&m=135754842927541&w=2
> 
> Could you please help out?

Please regard these things as ACKed.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
