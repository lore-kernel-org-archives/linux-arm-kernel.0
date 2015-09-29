From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Sep 2015 10:38:33 -0700
Subject: [PATCH 0/3] mmc: Wait for card_busy before starting sdio requests
In-Reply-To: <560A8AE6.9010603@redhat.com>
References: <1442935826-16758-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFqvnVTL0pDLc8S1Ssqmy5WXR9+=uCWq8ONmgrYU=Zzoow@mail.gmail.com>
 <5603C020.80603@redhat.com>
 <CAD=FV=UacwyVcX+ZwCJ+iuhTGyr8ktOw7EiMxng8G1EmwXomJQ@mail.gmail.com>
 <5604FD94.4020808@redhat.com>
 <CAD=FV=VVu5V77K073JAy884GZUAgeNUFmsJU4d-k4GGoW_6Tkg@mail.gmail.com>
 <560A8AE6.9010603@redhat.com>
Message-ID: <CAD=FV=Vq_mgY8atFjtRJSKobfS=Ez6M_8Uio7T4-G4OD+bjR_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hans,

On Tue, Sep 29, 2015 at 5:58 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> So perhaps it would be good to update your patch to check for all data
>> commands?
>
>
> Agreed, since you seem to know this stuff much better then I do can you do
> a follow-up patch expanding my patch to do the busy check / wait for
> all data commands?

Hmmm, what a strange thing to say about me.  ;)  I always kinda feel
like I'm bumbling around with most of this stuff.  If I've happened to
look at a particular issue in detail I know about it, but usually I
only know about the little bits that I've had to debug...  Really my
knowledge of SD/MMC/SDIO is limited to having to deal with dw_mmc
since all the SoCs I've worked with have had that controller.

I'll put it on my list to try to come up with a patch, but it might be
a while before I get to it since I've already god a whole lot of
"upstream wishlist" things that I haven't had time for.  My main work
keep promising to lighten up a little bit to pick some of these tasks
off.  If someone else is reading this and wants to take a crack at the
patch themselves, please don't wait for me.

-Doug
