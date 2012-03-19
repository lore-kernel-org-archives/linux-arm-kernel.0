From: dhowells@redhat.com (David Howells)
Date: Mon, 19 Mar 2012 10:45:11 +0000
Subject: [PATCH 05/38] Disintegrate asm/system.h for ARM [ver #3]
In-Reply-To: <1331908808.12353.2.camel@deneb.redhat.com>
References: <1331908808.12353.2.camel@deneb.redhat.com>
 <20120315205514.28759.58969.stgit@warthog.procyon.org.uk>
 <20120315205603.28759.91855.stgit@warthog.procyon.org.uk>
Message-ID: <2349.1332153911@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Salter <msalter@redhat.com> wrote:

> Looks like this hunk was unintended. It is causing a build failure for
> me.

Yep.  Removed that already and reissued the ARM chunk, though only on the ARM
list.

David
