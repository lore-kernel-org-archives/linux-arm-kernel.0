From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jun 2013 16:29:26 +0200
Subject: [PATCH 14/15] ARM: shmobile: Remove AP4EVB board support
In-Reply-To: <CANqRtoSx4Jf_EfG3LvkpoOED4-SuOdWjRedz-RbwGCOcOeP-Xg@mail.gmail.com>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1306132128370.3777@axis700.grange>
 <CANqRtoSx4Jf_EfG3LvkpoOED4-SuOdWjRedz-RbwGCOcOeP-Xg@mail.gmail.com>
Message-ID: <201306141629.26580.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 June 2013, Magnus Damm wrote:
> > If still possible, would be good to delay removing this board until we
> > complete our discussion.
> 
> If fine with keeping the board if someone can show me progress in the
> area of INTC DT support. Recently I have not seen anything.

As mentioned the last time we discussed this, I'm fine with using the
existing code and "legacy" irqdomain for the older INTC implementations,
as long as all the new ones can use your new generic code.

	Arnd
