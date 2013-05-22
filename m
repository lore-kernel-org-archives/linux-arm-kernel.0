From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 22 May 2013 08:50:32 +0800
Subject: [PATCH] arm64: kernel: need extern variable 'screen_info' for
 related driver using.
In-Reply-To: <20130521131539.GC27002@arm.com>
References: <5199B7D6.40907@asianux.com>
 <20130520091008.GB31359@mudshark.cambridge.arm.com>
 <519AE6D7.1090401@asianux.com>
 <CAMuHMdWNHPDkf35MYMKnxt5pn3a+dsT4jgYxuuHrp+mpZMckfw@mail.gmail.com>
 <519B278B.6030708@asianux.com>
 <20130521090336.GC10453@mudshark.cambridge.arm.com>
 <519B48B4.6050607@asianux.com> <20130521131539.GC27002@arm.com>
Message-ID: <519C1658.3040209@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 09:15 PM, Catalin Marinas wrote:
> On Tue, May 21, 2013 at 11:13:08AM +0100, Chen Gang wrote:
>> > On 05/21/2013 05:03 PM, Will Deacon wrote:
>>> > > On Tue, May 21, 2013 at 08:51:39AM +0100, Chen Gang wrote:
>>>> > >> For me, I still recommend add 'ARM64' in the long list of architectures
>>>> > >> for 'VGA_CONSOLE', I have 3 reasons, please check:
>>>> > >>
>>>> > >> a. current implementation only changes one area which only related with
>>>> > >> arm64 and 'VGA_CONSOLE', but if use 'CONFIG_HAVE_VGA_CONSOLE', that will
>>>> > >> touch many multiple platforms dependency, at least we need discuss about
>>>> > >> it with multiple platforms guys for it, firstly.
>>> > > 
>>> > > That's a weak argument. You might as well propose the cleanup and see what
>>> > > people say.
>> > 
>> > Hmm.. I think at least, we need discuss it with the 'final applier'
>> > firstly (and now, I even do not know who is the 'final applier').
> Well, you can post the patch to linux-arch, cc'ing the arch maintainers
> whose Kconfig files you touch. If there are no comments, it will most
> likely be picked by Andrew Morton and sent to Linus (make sure you cc
> Andrew as well).

OK, thanks. I will do with PARPORT_PC firstly, I think, it is a better
candidate than VGA_CONSOLE.

And excuse me, I have to do another things now, and I think I should
finish the PARPORT_PC within this week.


Thanks.
-- 
Chen Gang

Asianux Corporation
