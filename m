From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 May 2013 15:30:20 +0200
Subject: [PATCH v2 07/10] powerpc: uaccess s/might_sleep/might_fault/
In-Reply-To: <20130524131104.GA11462@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
 <20130524130032.GA10167@redhat.com> <20130524131104.GA11462@redhat.com>
Message-ID: <201305241530.20845.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 May 2013, Michael S. Tsirkin wrote:
> So this won't work, unless we add the is_kernel_addr check
> to might_fault. That will become possible on top of this patchset
> but let's consider this carefully, and make this a separate
> patchset, OK?

Yes, makes sense.

	Arnd
