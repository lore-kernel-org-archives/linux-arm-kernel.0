From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 17:53:35 +0100
Subject: [PATCH 1/4] ARM: clps711x: autcpu12: Fix incorrect NAND CLE GPIO
In-Reply-To: <20140218193906.d9ad07dc64c75f46e6c78257@mail.ru>
References: <1392451533-12858-1-git-send-email-shc_work@mail.ru>
 <201402181611.41742.arnd@arndb.de>
 <20140218193906.d9ad07dc64c75f46e6c78257@mail.ru>
Message-ID: <201402281753.35673.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 February 2014, Alexander Shiyan wrote:
> Before that, I tried to send an accompanying message to the arm at kernel.org,
> but unfortunately my email is blocked for sending to this address.
> 
> While I expect to applying some other patches for this architecture, I do a
> minor changes that do not have potential conflicts when applying one to
> the other. Yes, please apply them, if it possible.
> 

I've applied patches 2 and 3 in the next/cleanup branch now, and patches 1 and
4 as fixes-non-crictical.

I believe that is all you have sent at the moment, let me know if I have
missed other patches from you. Also make sure to always use the arm at kernel.org
alias when you actually want us to apply your patches, that way we can keep
track of it more easily.

	Arnd
