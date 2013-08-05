From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 5 Aug 2013 19:22:00 -0400
Subject: DT binding stalemate proposal, was: Re: [PATCH v9 29/30] bus:
 mvebu-mbus: Add devicetree binding
In-Reply-To: <CAL_Jsq+D6Np7tK5qCFvcsTVRPZsppYOpBPhR7n+BJPJ1ED-AMQ@mail.gmail.com>
References: <1374844687-19981-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1374844687-19981-30-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130805203655.GL19280@titan.lakedaemon.net>
 <CAL_Jsq+D6Np7tK5qCFvcsTVRPZsppYOpBPhR7n+BJPJ1ED-AMQ@mail.gmail.com>
Message-ID: <20130805232200.GM19280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 04:49:50PM -0500, Rob Herring wrote:
> On Mon, Aug 5, 2013 at 3:36 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > DT maintainers,
> >
> > I understand you guys are swamped with reviewing atm.  This binding in
> > particular is complicated, has a long history (9 versions just for the
> > devicetree binding itself), and no one wants to commit to supporting it
> > forever without fully understanding where it came from and why it's
> > needed.
> 
> Is there an actual objection in the current binding that is not
> addressed or just lack of approval? It seems to be the latter to me.

Correct.  The DT maintainership was announced just shortly before the
final version of this series was posted.  So it's purely bad timing.  It
was "good" according to the old rules, but we didn't want to assume that
meant the same thing now.

> > On the other side of the coin, we have other patches depending on this
> > work, and the submitters have been more than patient with the process
> > (and the maintainership change).  I'd prefer not to delay it if it can
> > be helped.
> >
> > So here's my proposal: Let use this as a guinea pig for the 'unstable'
> > class of bindings.  eg s:/bindings/:/bindings/unstable/:  and merge it
> > in.
> 
> What the unstable process looks like is not fully flushed out, and
> until it is we can't really hold up submissions if there are no
> objections. It also means we should not accept anything known to be
> unstable. This is self-contained to mvebu, so it is your problem to
> support or deal with any change.

Fair enough.

> > As we've said a couple of times, Arnd Bergmann has helped out plenty
> > with developing this binding, but he's not available for the next few
> > months.  So unless we do something, we're essentially starting over from
> > scratch.
> 
> My read of the history is that Arnd was pretty much in agreement.
> 
> The binding looks reasonable to me, but honestly I haven't studied it
> in depth. So given the above conditions:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Thanks Rob!  I appreciate it.

thx,

Jason.
