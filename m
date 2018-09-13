From: venture@google.com (Patrick Venture)
Date: Thu, 13 Sep 2018 16:31:31 -0700
Subject: [PATCH] arm: dts: aspeed: quanta-q71l: Enable adc & ibt nodes
In-Reply-To: <CACPK8XfH74Z1FYvWxU-vkxJ-APKG_w14dWMjLnj87eH-zrt02w@mail.gmail.com>
References: <20180904155329.258447-1-venture@google.com>
 <CACPK8XfH74Z1FYvWxU-vkxJ-APKG_w14dWMjLnj87eH-zrt02w@mail.gmail.com>
Message-ID: <CAO=notza+JB-1eVHLKVbux2fDV-KYrOvctNKfi1YBqomOmxT-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 4:30 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 5 Sep 2018 at 01:23, Patrick Venture <venture@google.com> wrote:
> >
> > ADC node is disabled by default in 4.13 tree onward and
> > needs to be enabled explicitly in separate device trees.
> >
> > ibt(ipmi-bt-host) node is disabled by default in 4.13 tree onward and
> > needs to be enabled explicitly in separate device trees.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
>
> Applied to dt-for-v4.20 with a tweak to the commit message. (FYI: the
> 4.13 messages relate to the openbmc tree; the upstream tree introduced
> these drivers earlier, and it has always been disabled in the dtsi).

Thanks -- sorry, didn't know that it was an openbmc-ism.
>
> Cheers,
>
> Joel
