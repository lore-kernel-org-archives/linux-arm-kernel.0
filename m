From: david.vrabel@csr.com (David Vrabel)
Date: Mon, 15 Feb 2010 11:58:06 +0000
Subject: [PATCH 3/3] [U300] Set f_max to 24 MHz for MMC
In-Reply-To: <1266233040-17124-1-git-send-email-linus.walleij@stericsson.com>
References: <1266233040-17124-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4B7936CE.9020402@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> +	mmci_card->mmc0_plat_data.f_max = 24*1024*1024;

Is the frequency really 25165824 Hz and not 24000000 Hz?

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
