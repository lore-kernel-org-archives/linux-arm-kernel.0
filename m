From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Dec 2012 11:57:56 +0000
Subject: [PATCH 2/3] CLK: uninline clk_prepare_enable() and
 clk_disable_unprepare()
In-Reply-To: <CAKohpomA=vSGuKfD-_zwiSnXGkqAQjtiVqxT2Po=D-LDA_FESg@mail.gmail.com>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-3-git-send-email-dmitry.torokhov@gmail.com>
 <CAKohpomA=vSGuKfD-_zwiSnXGkqAQjtiVqxT2Po=D-LDA_FESg@mail.gmail.com>
Message-ID: <20121216115756.GO14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 16, 2012 at 05:10:36PM +0530, Viresh Kumar wrote:
> On 20 November 2012 14:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > We'll need to invoke clk_disable_unprepare() via a pointer in our devm_*
> > conversion so let's uninline the pair.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Mike, are you taking these patches?

And what about my comments, some of which you've failed to reply to?
