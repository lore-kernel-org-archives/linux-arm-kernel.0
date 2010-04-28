From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 28 Apr 2010 11:22:45 -0700
Subject: [PATCH 1/4] MMC: atmel-mci: fix two parameters swapped
In-Reply-To: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
References: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
	<bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
Message-ID: <20100428112245.23e99d70.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches 1-3 (at least) appear to be applicable to 2.6.33.x and perhaps
earlier.

But you didn't cc stable at kernel.org and there was no Cc:
<stable@kernel.org> in the changelog and in this case I'd prefer not to
make that decision myself?
