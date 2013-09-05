From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Sep 2013 14:19:10 +0100
Subject: [PATCH 3/3] perf: parse the .debug_frame section in case
 .eh_frame is not present
In-Reply-To: <CAKv+Gu8u4PLVfng8ru4RFwA-+Ky0vYEP3V2=vecqndo5Z0sTJg@mail.gmail.com>
References: <1378317854-25965-1-git-send-email-jean.pihet@linaro.org>
 <1378317854-25965-4-git-send-email-jean.pihet@linaro.org>
 <20130905124508.GE9696@mudshark.cambridge.arm.com>
 <CAORVsuW-1koTMaSMgjagBz1aJ0AtvVRiM5gs3kwO2Fuvk+DhwQ@mail.gmail.com>
 <CAKv+Gu8u4PLVfng8ru4RFwA-+Ky0vYEP3V2=vecqndo5Z0sTJg@mail.gmail.com>
Message-ID: <20130905131910.GB22351@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 02:17:30PM +0100, Ard Biesheuvel wrote:
> On 5 September 2013 15:05, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> [..]
> > Here are the commands I have been using:
> >  perf record -g dwarf -- <binary to profile>
> >  perf report --sort symbol --call-graph --stdio
> >
> 
> Ah, I failed to add the 'dwarf' after -g, however, in that case, my
> perf report segfaults:

Same SEGV here.

Will
