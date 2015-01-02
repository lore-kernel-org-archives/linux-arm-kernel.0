From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 22:17:31 +0100
Subject: [RFC PATCH v3 1/4] arm64: defconfig: increase NR_CPUS range to
 2-4096.
In-Reply-To: <1420011208-7051-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1420011208-7051-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1420011208-7051-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <2122815.9bPyHWVuBd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 December 2014 13:03:25 Ganapatrao Kulkarni wrote:
> Raising the maximum limit to 4096.
> This is to accomadate up-coming higher multi-core platforms.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
