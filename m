From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Aug 2011 13:53:12 +0200
Subject: [PATCH 1/2] drivers: create a pinmux subsystem v3
In-Reply-To: <CAGsJ_4yKHQGrY4kbwd+VPsg1ggj3wQqoN+uPLmh31RnhbroysQ@mail.gmail.com>
References: <1307984291-9774-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4yKHQGrY4kbwd+VPsg1ggj3wQqoN+uPLmh31RnhbroysQ@mail.gmail.com>
Message-ID: <CACRpkdZB7XaB1SxWdqU1-176oab0zMjdu=YfNjgLFsLTztAwyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 7:57 AM, Barry Song <21cnbao@gmail.com> wrote:

> has this been ready for 3.1? we have been planning to write pinmux
> driver based on this framework.

On Mon, Aug 8, 2011 at 4:28 AM, Barry Song <21cnbao@gmail.com> wrote:

> What is the status of pincfg subsystem? what's the plan about merging
> this subsystem?

I failed, we needed feedback from some more players.
If you need this framework, please review and ACK the
patch set when you're happy with it so I know I have users who
are happy with it as it looks.

v4 is out today atleast. If there are no big objections so I have to
re-architect it again, I might be able to ask Stephen to pull it
into linux-next.

Thanks,
Linus Walleij
