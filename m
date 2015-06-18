From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 18 Jun 2015 08:57:09 +0200
Subject: [PATCH v6 06/14] crypto: marvell/CESA: add DES support
In-Reply-To: <1434527142-3609-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434527142-3609-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150618085709.2180759d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Wed, 17 Jun 2015 09:45:34 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Add support for DES operations.

The addition of DES support seems controversial. At first I thought it
would be good to support all the algorithms supported by the CESA
engine, but I think I'll drop it in the next iteration.

Do you think Triple-DES should be dropped too ?

Best Regards,

Boris 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
