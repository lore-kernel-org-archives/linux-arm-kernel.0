From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Jan 2014 20:50:24 +0100
Subject: [PATCH v3 1/2] i2c: qup: Add device tree bindings information
In-Reply-To: <174308F1-FFD2-4CB3-AEA2-C423F90FB133@codeaurora.org>
References: <1389999819-10648-1-git-send-email-bjorn.andersson@sonymobile.com>
 <CAL_JsqJBEu8iLzE8-dXniZFytr6cQsprBYiYnJeXS2-80iy1Mw@mail.gmail.com>
 <174308F1-FFD2-4CB3-AEA2-C423F90FB133@codeaurora.org>
Message-ID: <201401232050.25134.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 January 2014, Matthew Locke wrote:
> The QUP IP block is the same across chips.  Its possible there could be different versions of the IP block but its pretty stable now. 

Do you know the version numbers of the IP block? That would be the ideal case. We just
fall back to using the SoC name in most cases because that's all that is publically
known.

	Arnd
