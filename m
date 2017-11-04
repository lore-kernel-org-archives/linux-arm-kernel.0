From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 4 Nov 2017 20:06:01 +0800
Subject: [GIT PULL] ARM: actions: dt64 for v4.14
In-Reply-To: <CAK8P3a3X0YMAgO5eyJwTqw4WDyxpxQEn=5km7d5qWA=k5ZXfKg@mail.gmail.com>
References: <20170905223252.9478-1-afaerber@suse.de>
 <20170905223252.9478-2-afaerber@suse.de>
 <CAOesGMgJH_LEjOr_JAj+J9LRr-dYHy2zS2PAAJM96+hece=HUw@mail.gmail.com>
 <7368054b-8a2f-7f42-08fb-4fb58cd1c725@suse.de>
 <CAK8P3a3UwC9Jzmf=fJeprZN2DjL6osHTAVm8JFnKV4wAUFTrLw@mail.gmail.com>
 <CAK8P3a1FvFOYc+xzywXHoJN6wEJYDB5bH5w39EPJngzBrUqbSg@mail.gmail.com>
 <CAK8P3a0ad3UkMkJpxvyRc9+VRtSf_3xbVf55z4C6OGSHCx-t8w@mail.gmail.com>
 <CAK8P3a25yjLGM09aPf7y91BocSK=sUswGsNPVVwtZquDcwC1nQ@mail.gmail.com>
 <CAK8P3a3X0YMAgO5eyJwTqw4WDyxpxQEn=5km7d5qWA=k5ZXfKg@mail.gmail.com>
Message-ID: <138ecbe2-be50-ba45-13d6-fdefb7e2a514@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.11.2017 um 17:49 schrieb Arnd Bergmann:
> On Nov 4, 2017 10:34, "Andreas F?rber" <afaerber@suse.de
> <mailto:afaerber@suse.de>> wrote:
> 
>     Hi Olof,
> 
>     Am 16.09.2017 um 05:58 schrieb Olof Johansson:
>     > On Tue, Sep 5, 2017 at 3:32 PM, Andreas F?rber <afaerber@suse.de
>     <mailto:afaerber@suse.de>> wrote:
>     >> Hi Olof and Arnd,
>     >>
>     >> Here's a (late) dt64 pull for Actions Semi.
>     >> This clock node is needed to make use of the new full serial driver.
> 
> 
> 
> Please let us know earlier when you see problems. It missed the 4.14
> window since that late branch ended up being too late for us. We should
> have communicated this better, but we expected you to resend the
> contents for 4.15? early on. 

Sorry, when I read "merged" I consider that contents out of my hands -
and for 4.13 Linus complained about our elaborate drivers->soc merge.

Also I'm five weeks out of the office this merge window and it's been as
surprising as Christmas to see an -rc7 tagged already. ;)

> Also, don't hold back new content while you wait for other stuff to get
> merges, just keep the pull requests coming so we know what's going on.

Well, that didn't quite apply here, branches based on v4.14-rc1 vs.
v4.13-rc1 would cause merge conflicts. When based on the same tag, sure.

> If you send the full set of pull requests now and we get an -rc8
> tomorrow, we might still merge it all for 4.15, otherwise please resend
> it for 4.16 after the merge window.
Understood. I've updated for-next and sent out 4.15 pulls for Actions
(and Realtek) as good as I could from my hotel. If they don't make
v4.15-rc1 I'll rebase them and send immediate 4.16 pulls, with any
regular 4.16 contents going into a second round then.

I've tried to avoid sending you single-patch pulls, but on the other
hand waiting for the full patches to finish review for inclusion has not
been working well either.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
