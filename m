From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 6 Jun 2013 04:16:12 +0000 (UTC)
Subject: [PATCH 0/5] Broken DM816x support in Linux 3.10-rc4
In-Reply-To: <1370446156-11788-1-git-send-email-aida.mynzhasova@skitlab.ru>
References: <1370446156-11788-1-git-send-email-aida.mynzhasova@skitlab.ru>
Message-ID: <alpine.DEB.2.02.1306060414580.15042@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

also,

On Wed, 5 Jun 2013, Aida Mynzhasova wrote:

> Aida Mynzhasova (5):
>   ARM: OMAP: AM33xx: multiple renames for early initialization

If this patch is what's responsible for all the file renaming, please drop 
it.  Looks from the change summary that it's just useless churn (although 
I haven't seen the patch here since it never made it to the lists)


- Paul
