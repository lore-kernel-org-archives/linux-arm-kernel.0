From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Nov 2011 12:17:35 +0000
Subject: [PATCH v5 3/7] arm: perf: support device with other non-irq
 resources
In-Reply-To: <CACVXFVPD90q0euQXXG+3ujyvzxCjAovFSSPKvqf6esU7vkD7Tg@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-4-git-send-email-ming.lei@canonical.com>
 <20111024150814.GA4771@mudshark.cambridge.arm.com>
 <CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
 <20111025083420.GA6184@mudshark.cambridge.arm.com>
 <alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com>
 <CACVXFVOVeuWpVGSUP-sDDbiWb=W8XVB+PDYns4ttK9+ty0GMmA@mail.gmail.com>
 <alpine.DEB.2.00.1110250459160.12667@utopia.booyaka.com>
 <CACVXFVPD90q0euQXXG+3ujyvzxCjAovFSSPKvqf6esU7vkD7Tg@mail.gmail.com>
Message-ID: <20111108121735.GD28350@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 09:25:52AM +0000, Ming Lei wrote:
> On Tue, Oct 25, 2011 at 7:00 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Beno?t is the right person to review OMAP4 hwmod data.
> 
> Beno?t, gentle ping, :-)

Note that I've taken the two perf patches into my perf/omap4 branch now:

http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=shortlog;h=refs/heads/perf/omap4

so it would be really good to see the platform parts getting picked up too.

Will
