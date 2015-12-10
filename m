From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 00:23:53 +0100
Subject: [GIT PULL v2] at91: fixes for 4.4 #2
In-Reply-To: <20151206221706.GA25252@piout.net>
References: <20151206221706.GA25252@piout.net>
Message-ID: <16685847.9YucJUXR3U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 06 December 2015 23:17:06 Alexandre Belloni wrote:
> 
> As discussed with Arnd, there was an issue in the previous pinctrl
> selection which is necessary to get sama5d2 to work.
> 
> That pull request replaces th previous one sent by Nicolas. His message
> was:
> 
> "This is the second AT91 "fixes" for 4.4. This one allows the sama5d2 to
> properly boot with its PIO4 controller and use one of its main interfaces,
> with the 1.8 capable eMMC, on the sama5d2 Xplained reference platform."
> 
> 

Pulled into fixes now, thanks!

	Arnd
