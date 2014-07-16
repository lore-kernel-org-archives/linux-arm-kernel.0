From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 16 Jul 2014 16:35:24 +0200
Subject: [PATCH 04/19] serial: samsung: Remove support for legacy clock
 code
In-Reply-To: <1405520767.4408.39.camel@x220>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-5-git-send-email-t.figa@samsung.com>
 <1405502840.4408.2.camel@x220> <53C67386.5070401@samsung.com>
 <1405520767.4408.39.camel@x220>
Message-ID: <1405521324.4408.44.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 16:26 +0200, Paul Bolle wrote:
> On Wed, 2014-07-16 at 14:43 +0200, Tomasz Figa wrote:
> > That's right. Apparently I missed them. I guess that's not critical,
> > though, and could be done in separate patch, right?
> 
> This is not critical at all, so that's fine with me. 

Actually, that's only correct if the solution here is to just remove the
(currently) dead code hidden behind CONFIG_SAMSUNG_CLOCK. But if the
solution requires something less trivial, that might be quite wrong.

So please disregard my comment!


Paul Bolle
