From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Mar 2015 13:10:25 +0100
Subject: [PATCH] rtc: at91rm9200: Fix locking in interrupt handler
In-Reply-To: <1426416887-3450-1-git-send-email-davidcdueck@googlemail.com>
References: <1426416887-3450-1-git-send-email-davidcdueck@googlemail.com>
Message-ID: <12923849.5UvAiHoKLG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 March 2015 11:54:47 David Dueck wrote:
> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> 

Please always describe why a change is done. Was this a recent
regression? What caused it?

	Arnd
