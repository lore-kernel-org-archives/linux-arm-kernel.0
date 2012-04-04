From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 4 Apr 2012 19:29:43 +0200
Subject: AT91 module building breakage
Message-ID: <CAGhQ9VzqE4x4tAq0d3nTi_+Cn=PktmNLaYXEgNa8OH_NGoQdnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Right now some AT91 drivers can't be built as modules because of
missing symbols.
This is caused by some of the refactoring patches by Jean-Christophe
PLAGNIOL-VILLARD merged during the merge window.

I don't know how you prefer to fix the problem but I have create
patches which export the missing symbols.
http://marc.info/?l=linux-arm-kernel&m=133355983711996&w=2
http://marc.info/?l=linux-arm-kernel&m=133314157121376&w=2

btw, there might be more breakage than what I have found. This could
have easily been found if someone had tested building the drivers as
modules.

Would be nice if this could be fixed before rc2.

regards
Joachim Eastwood
