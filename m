From: dhowells@redhat.com (David Howells)
Date: Fri, 07 Sep 2018 09:47:26 +0100
Subject: Regression in next with filesystem context concept
In-Reply-To: <20180906164358.GI5659@atomide.com>
References: <20180906164358.GI5659@atomide.com>
Message-ID: <9053.1536310046@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> wrote:

> Looks like next-20180906 now has a regression where mounting
> root won't work with commit fd0002870b45 ("vfs: Implement a
> filesystem superblock creation/configuration context").

Am I right in thinking you're not using any of the LSMs?

David
