From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 21 Dec 2012 10:28:48 +0000
Subject: [PATCH 5/9] mailbox: change protection mechanisms
In-Reply-To: <1355836212-17956-6-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-6-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC9CE80@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 18:40:08, Loic Pallardy wrote:
> TX: replace spin by mutex
> RX: replace spin_lock_irq by spin_lock_irqsave
> 

Can you please add a short note on why this is being done?

Regards,
Vaibhav 
