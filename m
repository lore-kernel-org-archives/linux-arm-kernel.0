From: hansverk@cisco.com (Hans Verkuil)
Date: Tue, 21 May 2013 09:38:42 +0200
Subject: [PATCH] Finally eradicate CONFIG_HOTPLUG
In-Reply-To: <20130521134935.d18c3f5c23485fb5ddabc365@canb.auug.org.au>
References: <20130521134935.d18c3f5c23485fb5ddabc365@canb.auug.org.au>
Message-ID: <201305210938.43064.hansverk@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 21 May 2013 05:49:35 Stephen Rothwell wrote:
> Ever since commit 45f035ab9b8f ("CONFIG_HOTPLUG should be always on"),
> it has been basically impossible to build a kernel with CONFIG_HOTPLUG
> turned off.  Remove all the remaining references to it.
> 
> Cc: linux-arch at vger.kernel.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Doug Thompson <dougthompson@xmission.com>
> Cc: linux-edac at vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci at vger.kernel.org
> Cc: linux-pcmcia at lists.infradead.org
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Steven Whitehouse <swhiteho@redhat.com>
> Cc: cluster-devel at redhat.com
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: linux-pm at vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm at kvack.org
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

For drivers/staging/media/go7007/go7007.txt:

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
