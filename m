From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Sep 2017 07:37:34 -0700
Subject: [PATCH 01/10] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
In-Reply-To: <20170925070345.2uraikhswru77rm4@squirrel.local>
References: <20170920224621.16236-1-tony@atomide.com>
 <20170920224621.16236-2-tony@atomide.com>
 <20170925070345.2uraikhswru77rm4@squirrel.local>
Message-ID: <20170925143733.GF4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [170925 00:04]:
> On Wed, Sep 20, 2017 at 03:46:12PM -0700, Tony Lindgren wrote:
> > TI sysc interconnect target module hardware is independent of the
> > interconnect. It is used at least with TI L3 interconnect (Arteris NoC)
> > and TI L4 interconnect (Sonics s3220).
> 
> This is because the interface between interconnect and module is
> standardized (Open Core Protocol), so it doesn't really matter which
> interconnect technology is used.
> 
> Also, afaik sysc mostly just concerns the interaction between module and
> PRCM.  The only role the interconnect plays here is that it participates
> in the OCP Disconnect Protocol to allow the module to safely disconnect
> itself when it or the interconnect enters idle state.

OK thanks for clarifying it, I'll add a note regarding OCP there.

Regards,

Tony
