From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 9 Dec 2013 09:37:48 +0000
Subject: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
In-Reply-To: <20131208190739.GA18977@saruman.home>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
 <20131203095136.GF11828@lee--X1>
 <20131208190739.GA18977@saruman.home>
Message-ID: <20131209093748.GA12675@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The code looks mostly fine, but the implementation of the commit logs
> > seems lazy. Please submit a v3 using coherent sentences with full
> > explanations and correct punctuation.
> 
> example ?

All of your commit messages.

> that macro just helps removing some extra

  ^- Sentences start with an uppercase character.

> line of code and hides ffs() calls.
> 
> while at that, also fix a variable shadowing

  ^- Sentences start with an uppercase character.

> bug where 'int irq' was being redeclared inside
> inner loop while it was also argument to interrupt
> handler.

  < ---------------   50 chars   ----------------- >

Please use the full 72 char (or there abouts) width of the buffer.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
