From: joe@perches.com (Joe Perches)
Date: Tue, 24 Jul 2018 17:13:20 -0700
Subject: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
In-Reply-To: <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
References: <20180724111600.4158975-1-arnd@arndb.de>
 <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
Message-ID: <aa39b6d15f44555cb79d5ebdef74aeab19003d6a.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-24 at 14:00 -0700, Andrew Morton wrote:
> On Tue, 24 Jul 2018 13:13:25 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > Almost all files in the kernel are either plain text or UTF-8
> > encoded. A couple however are ISO_8859-1, usually just a few
> > characters in a C comments, for historic reasons.
> > This converts them all to UTF-8 for consistency.
[]
> Will we be getting a checkpatch rule to keep things this way?

How would that be done?
