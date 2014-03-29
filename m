From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 29 Mar 2014 10:06:39 +0100
Subject: [RFC PATCH v2 03/10] ARM: at91: introduce OLD_IRQ_AT91 Kconfig
 option
In-Reply-To: <1396029548-10928-4-git-send-email-b.brezillon.dev@gmail.com>
References: <1396029548-10928-1-git-send-email-b.brezillon.dev@gmail.com>
 <1396029548-10928-4-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140329100639.5ea454bc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Boris BREZILLON,

On Fri, 28 Mar 2014 18:59:01 +0100, Boris BREZILLON wrote:

> +config OLD_IRQ_AT91
> +	bool
> +	default false

I don't think "default false" is a valid Kconfig construct. It could be
"default n", but that's useless since "default n" is the default
behavior. So I believe you can simply get rid of that line.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
