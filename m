From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 23 May 2015 09:49:30 +0200
Subject: [PATCH v2 1/7] clk: Add a basic factor clock
In-Reply-To: <CAGb2v64rqRC24wPWz5xYZv=w2QAtsCb-pd76Qynkb5NBCptXhQ@mail.gmail.com>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
 <1432241646-9511-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64rqRC24wPWz5xYZv=w2QAtsCb-pd76Qynkb5NBCptXhQ@mail.gmail.com>
Message-ID: <20150523074930.GI8557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 12:35:35PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, May 22, 2015 at 4:54 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some clocks are using a factor component, however, unlike their mux, gate
> > or divider counterpart, these factors don't have a basic clock
> > implementation.
> 
> I think "multiplier" would be a better name here, considering it is the
> counterpart of "divider". "factor" implies you can multiply and/or divide
> the clock rate.

You're probably right, I didn't though of it that way :)

> Unless of course you plan to add that? :)

Hmmm, no, not really.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150523/e78aa35e/attachment.sig>
