From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Jan 2017 10:35:33 +0100
Subject: [PATCH] ARM: shmobile: rcar-gen2: Add more register documentation
In-Reply-To: <CAMuHMdWzsLANJBHzw8kcf0zEWRCJxr5w2nBzgkSutq=rNftMsw@mail.gmail.com>
References: <1484917448-8320-1-git-send-email-geert+renesas@glider.be>
 <9d12d719-0866-a454-88e2-d51a695085cd@cogentembedded.com>
 <CAMuHMdWzsLANJBHzw8kcf0zEWRCJxr5w2nBzgkSutq=rNftMsw@mail.gmail.com>
Message-ID: <20170123093532.GI31651@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 10:11:20AM +0100, Geert Uytterhoeven wrote:
> Hi Sergei,
> 
> On Fri, Jan 20, 2017 at 5:21 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > On 01/20/2017 04:04 PM, Geert Uytterhoeven wrote:
> >
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >>  arch/arm/mach-shmobile/pm-rcar-gen2.c | 40
> >> +++++++++++++++++++++++++----------
> >>  1 file changed, 29 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c
> >> b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> >> index dd9ac366868f4336..6ed9aa19c4d34766 100644
> >> --- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
> >> +++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> >> @@ -20,14 +20,30 @@
> >
> > [...]
> >>
> >> +static inline u32 phys_to_sbar(phys_addr_t addr)
> >> +{
> >> +       return (((addr) >> 8) & 0xfffffc00);
> >
> >
> >   It's not a macro -- innermost parens not needed...
> 
> Thanks, outermost neither ;-)

Geert, I'm assuming you will respin this.
Let me know if that is not the case.
