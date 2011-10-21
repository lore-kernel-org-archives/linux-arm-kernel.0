From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Oct 2011 17:08:56 +0200
Subject: [PATCH arm-soc.git/for-next] ARM: l2x0: Fix merge typo with "ARM:
	l2x0: add empty l2x0_of_init"
In-Reply-To: <1319195043-20268-1-git-send-email-jarkko.nikula@bitmer.com>
References: <1319195043-20268-1-git-send-email-jarkko.nikula@bitmer.com>
Message-ID: <201110211708.57430.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 October 2011, Jarkko Nikula wrote:
> Fix build error "error: implicit declaration of function 'l2x0_init'" if
> CONFIG_OF is not set. This looks like to be caused by some manual typo when
> committing or merging as this is not in the original patch.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Rob Herring <rob.herring@calxeda.com>


Hi Jarkko,

The bug was introduce by a broken rebase on my side. I've redone this now and hope
I got it right this time.

Thanks for the report!

	Arnd
