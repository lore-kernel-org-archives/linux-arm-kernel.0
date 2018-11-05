From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2018 15:59:15 -0800
Subject: [PATCH RESEND] dmaengine: pxa: make the filter function internal
In-Reply-To: <874lcvm9sf.fsf@belgarion.home>
References: <20181105194503.25639-1-daniel@zonque.org>
 <874lcvm9sf.fsf@belgarion.home>
Message-ID: <CAOesGMjrdhQqSygAZbAjd2Gzwfgs78ZK=vJZj+L-Ns_MY=tvJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2018 at 2:37 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> Daniel Mack <daniel@zonque.org> writes:
>
> > From: Robert Jarzmik <robert.jarzmik@free.fr>
> >
> > As the pxa architecture and all its related drivers do not rely anymore
> > on the filter function, thanks to the slave map conversion, make
> > pxad_filter_fn() static, and remove it from the global namespace.
> >
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >
> > I'm resending this as it appears to be the last patch that's missing
> > from the PXA DMA transition series.
> >
> > Robert, any reason why it wasn't applied?
> Ah this is because my pull request was ... not taken into account.
>
> Arnd, Kevin, Olof, did you receive this
> https://www.spinics.net/lists/arm-kernel/msg679383.html ? It might be my mailer
> getting me into trouble once more.

I only have a record of the DT pull request here, so yeah, something
must have happened to that one. It's odd that it got to the archive
but not my mail client though.

Either that, or it got labelled as Spam and auto-purged since it was a
little while ago.

In the future, if we haven't merged in 1 or 2 weeks, feel free to ping.


-Olof


-Olof
