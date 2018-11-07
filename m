From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Nov 2018 09:36:02 -0800
Subject: [Ksummit-discuss] [TECH TOPIC] SoC maintainer group
In-Reply-To: <3189677.9XQFCzzJyO@avalon>
References: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
 <3189677.9XQFCzzJyO@avalon>
Message-ID: <CAOesGMi84d+ZSK49Cf26Wvy5mU8D8VkUK1zvfs-a=eSYD+4osw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 6, 2018 at 3:32 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Olof,
>
> On Wednesday, 7 November 2018 00:16:27 EET Olof Johansson wrote:
> > Hi KS organizers (and others),
> >
> > This is a late topic proposal, hopefully there is still time on the agenda.
> >
> > We?ve recently been discussing some maintainer model changes as
> > described below, and would like a slot to discuss the idea and solicit
> > feedback/comments from the others there.
> >
> >
> > This started with Arnd and I finally being in one place at the same
> > time, and talking about how we want to evolve arm-soc maintainership
> > moving forward. We've been independently thinking of ways to expand
> > the group and making it more self-service for everybody, but there's a
> > bunch of tooling needed to make it run smoothly beyond the smaller
> > group we have now.
> >
> > In the end, we ended up looking at it from a slightly different angle:
> > Right now, when contributors show up with new platform support, the
> > first hill they need to climb is figuring out how they need to carve
> > up their platform among all the various maintainers, how to make sure
> > they're all handshaking on keeping things stable, and get code
> > submitted. It's awkward, not well documented and one of the biggest
> > overheads we have on our side as well.
> >
> > When we started talking to other maintainers, we're also realizing
> > that we are currently duplicating a lot of work. In particular, we
> > often all get cc:d on patch series, so we all need to read and filter,
> > and assume that other maintainers spot the right patches, etc.
> >
> > We have discussed a few different options, and it seems like pooling
> > more of the contribution flow to a group of co-maintainers is a useful
> > approach. Initially, we're considering the arm-soc platforms, clock
> > drivers and pinctrl drivers, which all tend to be affected by new
> > platform contributions in this way, and often end up cross-cc:d on
> > everything. Additionally, the flow for successfully merging a new
> > platform or SoC needs to be documented and advertised. This is true
> > whether or not we change the way that maintainers coordinate amongst
> > themselves, or whether or not we change the current workflow used by
> > platform contributors today.
> >
> > So, we're planning to change things up a bit. We're starting a new
> > group that pools current arm-soc, clk and pinctrl drivers and
> > maintainers into one funnel. We'll set up a new mail alias for the
> > maintainer group, and one shared patchwork to collect contributions.
> > We still expect developers to use existing mailing lists, and we still
> > expect for example ARM platform maintainers to keep their workflow of
> > collecting patches for their platform like they do today. Down the
> > road it might make sense to incorporate other driver subsystems as
> > well.
> >
> > Beyond this, we're going to keep a close eye on the drm-misc tree,
> > which is exploring a move to gitlab (and working with gitlab on adding
> > the features they need to move over). If they get a broad maintainer
> > model working well in that environment it could be something we reuse
> > for ourselves too.
>
> gitlab is an umbrella term that covers many features proposed by the product.
> Are there particular features that you already think you would be interested
> in, or features that you already know you wouldn't want to use ?

To be honest, I haven't looked closely yet and I'm looking forward to
learning about what the DRM plans are during LPC.


-Olof
