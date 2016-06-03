From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 3 Jun 2016 14:00:49 -0600
Subject: [PATCH 1/2] DT: bindings: remove bcm2835-sdhci
In-Reply-To: <1464983233-27001-2-git-send-email-stefan.wahren@i2se.com>
References: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
 <1464983233-27001-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <5751E1F1.5020202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2016 01:47 PM, Stefan Wahren wrote:
> The sdhci-iproc also supports bcm2835. So this binding is obsolete.

sdhci-iproc supports this binding, so I don't believe the binding is 
obsolete. The duplicate implementations (drivers) can possibly be 
removed, but not the binding doc, which is (or at least could be) still 
in use.
