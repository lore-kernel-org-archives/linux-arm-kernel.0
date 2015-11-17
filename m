From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 23:09:05 +0100
Subject: [PATCH v6 16/19] aarch64: ilp32: use generic stat64 structure
In-Reply-To: <1447795019-30176-17-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-17-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <4020528.IPMzSqapue@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 00:16:56 Yury Norov wrote:
> Generic 32-bit and AARCH32 stat64 structures has same names.
> ILP32 needs generic stat64. So we can either make ILP32 mutual
> exclusive with AARCH32, or duplicate generic cp_new_stat64 code
> and struct stat64 to sys_ilp32.c. We choose second because it's
> more flexible to have independend support for ABIs.
> 

I commented on the previous version, but you have not replied to that,
or changed anything.

	Arnd
