From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Tue, 13 Dec 2011 14:53:31 +0400
Subject: [PATCH 08/19] dma: MX3_IPU fix depends
In-Reply-To: <1323757911-25217-8-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
 <1323757911-25217-8-git-send-email-eric@eukrea.com>
Message-ID: <4EE72EAB.4040308@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-12-2011 10:31, Eric B?nard wrote:

> ARCH_MX3 was removed in e760b5260d39113794da17c64cbd6e6311155b66

    Please also specify that commit's summary in parens.

> thus preventing to select MX3_IPU, thus preventing IPU and display
> to work on i.MX3x SOC.

> Signed-off-by: Eric B?nard<eric@eukrea.com>
> Cc: Sascha Hauer<kernel@pengutronix.de>
> Cc: Vinod Koul<vinod.koul@intel.com>
> Cc: Dan Williams<dan.j.williams@intel.com>

WBR, Sergei
