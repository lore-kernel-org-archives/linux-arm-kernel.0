From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Feb 2016 18:11:01 +0100
Subject: [PATCH v3 1/5] clk: sunxi: Add apb0 gates for H3
In-Reply-To: <20160206112605.4005784d1d0962c8adfe58a0@free.fr>
References: <1454542430-16572-1-git-send-email-k@japko.eu>
 <1454542430-16572-2-git-send-email-k@japko.eu>
 <20160204154752.4df7808be3364a98c496c030@free.fr>
 <20160205111152.GA31506@lukather>
 <20160206112605.4005784d1d0962c8adfe58a0@free.fr>
Message-ID: <20160209171101.GS31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 11:26:05AM +0100, Jean-Francois Moine wrote:
> On Fri, 5 Feb 2016 12:11:52 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > However, I'd like to keep per-soc and per-clocks compatibles in the
> > DT, in case we need to protect a clock in the future.
> 
> What do you mean by "protect a clock"?

Prevent it from shutting down.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/4fa6d3c3/attachment.sig>
