From: corbet@lwn.net (Jonathan Corbet)
Date: Thu, 18 Aug 2016 16:39:54 -0600
Subject: [PATCH] mm, kasan: Update kasan docs to indicate arm64 support
In-Reply-To: <1471365031-27115-1-git-send-email-labbott@redhat.com>
References: <1471365031-27115-1-git-send-email-labbott@redhat.com>
Message-ID: <20160818163954.43e59f0e@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Aug 2016 09:30:31 -0700
Laura Abbott <labbott@redhat.com> wrote:

> KASAN has been supported on arm64 since 39d114ddc682 ("arm64: add KASAN
> support"). Update the docs to indicate this.

This creates a conflict with my patch sphinxifying this file, of course,
but I'll cope.  Applied to the docs tree, thanks.

jon
