From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 24 Oct 2013 10:09:12 +0200
Subject: [RFC PATCH 00/11] Embeddable Position Independent Executable
In-Reply-To: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <201310241009.12597.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 17. September 2013, 14:43:26 schrieb Russ Dill:
> This patch adds support for and demonstrates the usage of an embedded
> position independent executable (PIE). The goal is to allow the use of C
> code in situations where carefully written position independent assembly
> was previously required.

As suggested yesterday evening by Kevin Hilman, just adding my 2ct of support.

This series looks exactly like the foundation I'll need at some point in the 
(probably still distant) future to handle suspend on my Rockchip platform - 
where like in your example stuff like putting the ram into selfrefresh has to 
be done by the os.


Thanks for the work on this
Heiko
