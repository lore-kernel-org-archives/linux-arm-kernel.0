From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Oct 2015 22:51 +0100
Subject: [PATCH] arm: spinlock: const qualify read-only functions
In-Reply-To: <1446061495-38554-1-git-send-email-icoolidge@google.com>
References: <1446061495-38554-1-git-send-email-icoolidge@google.com>
Message-ID: <4229998.loM0Ug13ZK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 October 2015 12:44:54 Ian Coolidge wrote:
> This allows assert_spin_locked() to be used against
> spinlocks that are const qualified.
> 
> Signed-off-by: Ian Coolidge <icoolidge@google.com>
> 

Can you give an example in the changelog where this might
be useful? Constant spinlocks seem counterintuitive.

	Arnd
