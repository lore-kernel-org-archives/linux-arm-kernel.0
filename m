From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Aug 2013 18:04:30 +0100
Subject: [alsa-devel] [PATCH 1/3] ASoC: bt-sco: enable OF support
In-Reply-To: <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
Message-ID: <20130806170430.GL6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 08:09:18AM +0800, Barry Song wrote:
> 2013/7/17 Mark Brown <broonie@kernel.org>:

> > There is likely to be a control interface for the BT device hanging off
> > a UART but it's not clear there's much more meaningful data for those
> > than there is here.

> so the idea is that we don't add codec platform device in uart, and we
> add a dt node for it as we are doing here?

Well, I think it's more OK to add a node like this one (possibly with a
link to the UART) but if you can add it based on it hanging off the UART
that's even better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130806/e86652a7/attachment.sig>
