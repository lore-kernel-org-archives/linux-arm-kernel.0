From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 4 Sep 2018 14:12:50 -0700
Subject: [GIT PULL] Amlogic fixes for v4.19-rc
In-Reply-To: <CAFBinCB3_P2mGR0HaxrARScVODoag78dkGBD_w46nNFJR=dnVQ@mail.gmail.com>
References: <7hk1o9895g.fsf@baylibre.com>
 <20180829185450.wmmyoona2hrapnj6@localhost>
 <CAOi56cWrNfFKe7+FkhMiCsSaeW7Fy8=pMA7H+yx_qhFMkadh5Q@mail.gmail.com>
 <CAOesGMgzWwVr6K9u-QJzOfF5PSgXmqKuAN8+cc42fSHskPV7=Q@mail.gmail.com>
 <CAFBinCB3_P2mGR0HaxrARScVODoag78dkGBD_w46nNFJR=dnVQ@mail.gmail.com>
Message-ID: <CAOi56cX-Jqg5Z71eNd42HoFwcvNAm+qFieYa=c-hsPw86dmBfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2018 at 2:30 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Kevin,
>
> On Sun, Sep 2, 2018 at 3:22 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 29, 2018 at 1:42 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> > > On Wed, Aug 29, 2018 at 1:31 PM Olof Johansson <olof@lixom.net> wrote:
> > >>
> > >> On Wed, Aug 29, 2018 at 08:50:03AM -0700, Kevin Hilman wrote:
> > >> > Olof, Arnd,
> > >> >
> > >> > A round of DT fixes for Amlogic SoCs for v4.19-rc.
> > >> >
> > >> > The are all platform-specific DT, 2 are simple fixes, and the 3
> > >> > meson-axg patches are to enable audio devices that were fully enabled by
> > >> > reset changes in the late PR recently sent and merged.
> > >> >
> > >> > Kevin
> > >> >
> > >> > The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> > >> >
> > >> >   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> > >> >
> > >> > are available in the git repository at:
> > >> >
> > >> >   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes
> > >> >
> > >> > for you to fetch changes up to 1caa378e092f22d02e8a46216cbf1c8e8101163a:
> > >> >
> > >> >   ARM: dts: meson8b: fix the clock controller register size (2018-08-29 08:38:21 -0700)
> > >> >
> > >> > ----------------------------------------------------------------
> > >> > Amlogic DT fixes for v4.19-rc
> > >> > - meson8b: fix clock controller register sizes
> I don't think it's worth re-building a "fixes" branch if it's just for
> my two patches
> the register sizes have been incorrect basically since forever
> so I'm also happy if these go into 4.20/5.0 (however it's going to be called)

OK, I'll just queue everything for $NEXT

Kevin
