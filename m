From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 26 Jan 2015 14:44:53 +0100
Subject: [PATCH v2 02/12] pm: at91: Workaround DDRSDRC self-refresh bug
 with LPDDR1 memories.
In-Reply-To: <54C6426E.9090808@atmel.com>
References: <1422265005-22937-1-git-send-email-wenyou.yang@atmel.com>
 <1422265139-23011-1-git-send-email-wenyou.yang@atmel.com>
 <20150126103605.GA20837@gradator.net> <54C6426E.9090808@atmel.com>
Message-ID: <20150126134453.GA27559@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

On Mon, Jan 26, 2015 at 02:34:38PM +0100, Nicolas Ferre wrote:
> Le 26/01/2015 11:36, Sylvain Rochet a ?crit :
> > 
> > I think we should explain we are dealing with an errata here, this is 
> > not obvious at first sight, the patch summary may find its place here :-)
> 
> True but the problem is that this errata is not public yet, it will be
> in a couple of weeks.
> 
> I have the feeling though that the commit message is pretty clear. We'll
> maybe add that it"s an actual errata.

Humm, this is not what I meant actually. I only proposed a code source 
comment explaining why this is done this way, the current patch summary 
looked like it will be perfect between /* */ ;-)

Sylvain
