From: davem@davemloft.net (David Miller)
Date: Thu, 06 Aug 2015 23:58:49 -0700 (PDT)
Subject: [PATCH net] net: thunderx: remove effective "default y" from
 Kconfig if ARCH_THUNDER=y
In-Reply-To: <1438716355-11515-1-git-send-email-ijc@hellion.org.uk>
References: <1438716355-11515-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <20150806.235849.1866973399577659068.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ian Campbell <ijc@hellion.org.uk>
Date: Tue,  4 Aug 2015 20:25:55 +0100

> As well as for kernels built only for ThunderX ARCH_THUNDERX is also enabled
> for kernels which support multiple platforms (such as distro kernels). Thus
> "default ARCH_THUNDER" is inappropriate.
> 
> I believe default m is equally frowned upon, so remove the line completely
> rather than "default m if ARCH_THUNDER".
> 
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>

Applied.
