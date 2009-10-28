From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Wed, 28 Oct 2009 10:59:36 +0200
Subject: staging/dream: add gpio and pmem support
In-Reply-To: <20091022091333.GA31023@elf.ucw.cz>
References: <20091022091333.GA31023@elf.ucw.cz>
Message-ID: <4AE807F8.2040909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2009 12:13 PM, Pavel Machek wrote:
>
> This adds generic_gpio and pmem support, both are needed for other
> dream drivers.

Why you are not using existing gpiolib? That would make your driver a
lot smaller and cleaner... and possibly with less bugs...

Why not split gpio and pmem into separate patches?

> Signed-off-by: Pavel Machek<pavel@ucw.cz>
