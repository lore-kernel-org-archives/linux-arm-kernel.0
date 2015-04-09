From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Apr 2015 22:17:28 +0200
Subject: [PATCH 2/2] arm64: add KASan support
In-Reply-To: <1427208544-8232-3-git-send-email-a.ryabinin@samsung.com>
References: <1427208544-8232-1-git-send-email-a.ryabinin@samsung.com>
 <1427208544-8232-3-git-send-email-a.ryabinin@samsung.com>
Message-ID: <3164609.kEhR8riVSV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 March 2015 17:49:04 Andrey Ryabinin wrote:
>  arch/arm64/mm/kasan_init.c           | 211 +++++++++++++++++++++++++++++++++++
> 

Just one very high-level question: as this code is clearly derived from
the x86 version and nontrivial, could we move most of it out of
arch/{x86,arm64} into mm/kasan/init.c and have the rest in some header
file?

	Arnd
