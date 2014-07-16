From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 16 Jul 2014 16:26:07 +0200
Subject: [PATCH 04/19] serial: samsung: Remove support for legacy clock
 code
In-Reply-To: <53C67386.5070401@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-5-git-send-email-t.figa@samsung.com>
 <1405502840.4408.2.camel@x220> <53C67386.5070401@samsung.com>
Message-ID: <1405520767.4408.39.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 14:43 +0200, Tomasz Figa wrote:
> On 16.07.2014 11:27, Paul Bolle wrote:
> > There are three further references to CONFIG_SAMSUNG_CLOCK in this file.
> > Those should be removed too, shouldn't they?
> 
> That's right. Apparently I missed them. I guess that's not critical,
> though, and could be done in separate patch, right?

This is not critical at all, so that's fine with me. 


Paul Bolle
