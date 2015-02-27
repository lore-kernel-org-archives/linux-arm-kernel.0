From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 27 Feb 2015 23:41:05 +0100
Subject: [PATCH] genirq: better describe IRQF_NO_SUSPEND semantics
In-Reply-To: <20150227150810.685084df@lwn.net>
References: <1424444026-31231-1-git-send-email-mark.rutland@arm.com>
 <20150227150810.685084df@lwn.net>
Message-ID: <1425092792.1YLq228Omk@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 27, 2015 03:08:10 PM Jonathan Corbet wrote:
> On Fri, 20 Feb 2015 14:53:46 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > This patch updates the documentation regarding IRQF_NO_SUSPEND to make
> > this caveat explicit, hopefully making future misuse rarer. Cleanup of
> > existing misuse will occur as part of later patch series.
> 
> Applied (with Peter's ack) to the docs tree.

Well, I've applied it too in the meantime. :-)

Also I'll have more commits on top of it, so it's better if it goes through
my tree I think, if you don't mind.

Rafael
