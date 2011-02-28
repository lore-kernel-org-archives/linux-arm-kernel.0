From: ben@trinity.fluff.org (Ben Dooks)
Date: Mon, 28 Feb 2011 13:32:57 +0000
Subject: Linux support for Samsung S3C2510A Processor
In-Reply-To: <AANLkTinBZCQ7Q+BaSxhm62pKiZHhmVWAgNzxnm5jBhZy@mail.gmail.com>
References: <AANLkTinBZCQ7Q+BaSxhm62pKiZHhmVWAgNzxnm5jBhZy@mail.gmail.com>
Message-ID: <20110228133256.GB22646@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 06:52:15PM +0530, Madhavi Manchala wrote:
> Dear All,
> 
> Does Linux kernel supports the Samsung S3C2510A processor? Why am I
> asking this question is, when I looked into  the arch/arm/ directory I
> did not find anything which is related to Samsung S3C2510A processor.
> There are other directories like mach-s3c24xx and mach-s3c64xx
> directories, but not mach-s3c25xx.
> 
> Any ideas / hints will be appreciated.

I think this is a no-mmu version, and there is not a lot of ARM no-mmu
support at the moment.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
