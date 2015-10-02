From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 02 Oct 2015 09:06:48 +0200
Subject: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
In-Reply-To: <560DF150.3000906@samsung.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
 <CAPDyKFqrkYXsbBJ61yYo0G8za1szARvA=as-5nLTiwGH5pCrEQ@mail.gmail.com>
 <560DF150.3000906@samsung.com>
Message-ID: <3312969.jJ2hfB2JkV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 2. Oktober 2015, 11:52:00 schrieb Jaehoon Chung:
> On 10/02/2015 06:05 AM, Ulf Hansson wrote:
> > On 1 October 2015 at 19:35, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> On 10/01, Heiko St?bner wrote:
> >>> Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
> >>>> On 30 September 2015 at 16:55, Heiko St?bner <heiko@sntech.de> wrote:
> >>>>> Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
> >>>>>> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de> 
wrote:
> >>>>> The clock changes of course only touch internals of the phase-clocks,
> >>>>> so
> >>>>> should have no problem going through another tree.
> >>>> 
> >>>> What happens if I take mmc and dt changes, wouldn't I need the clock
> >>>> patches as well?
> >>> 
> >>> The API stays of course the same, only the degree to settings
> >>> translation gets optimized, so I guess in the worst case you would get
> >>> no good phase and thus fall back to non-highspeed modes - but the
> >>> system would stay running.
> >>> 
> >>> But of course, if the clock maintainers could Ack the two clock patches
> >>> and
> >>> everything would stay together that would work even better :-)
> >> 
> >> If Ulf doesn't want to take them we can apply them to clk tree.
> >> Otherwise, you can have my acked-by on the clk patches.
> > 
> > I don't mind picking up the clock patches. So I consider this as an
> > ack for both patch 1 and patch2, thanks.
> > 
> > Now, let's give Jaehoon some time to review the dw_mmc parts.
> 
> I will check other patches on today, if it's ok, i will apply at my
> repository. Thanks for giving time! :)

I think Ulf wanted to apply the whole series via the mmc tree directly, but I 
guess that is between you two to decide ;-)


Heiko
