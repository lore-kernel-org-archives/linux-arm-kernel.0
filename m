From: john@stoffel.org (John Stoffel)
Date: Fri, 27 Jul 2012 10:11:33 -0400
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
Message-ID: <20498.41365.853741.261834@quad.stoffel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Sandeep Singh <Sandeep@freescale.com>
> TDM Framework is an attempt to provide a platform independent layer which can
> offer a standard interface  for TDM access to different client modules.

Please don't use TLAs (Three Letter Acronyms) like TDM without
explaining the clearly and up front.  It makes it hard for anyone else
who doens't know your code to look it over without having to spend
lots of time poking around to figure it out from either context or
somewhere else.

John
