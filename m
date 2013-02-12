From: joe@perches.com (Joe Perches)
Date: Tue, 12 Feb 2013 10:22:22 -0800
Subject: [PATCH V4 1/2] get_maintainer: allow keywords to match filenames
In-Reply-To: <511A8743.9010408@wwwdotorg.org>
References: <1360629574-23989-1-git-send-email-swarren@wwwdotorg.org>
 <1360649875.5128.18.camel@joe-AO722> <511A8743.9010408@wwwdotorg.org>
Message-ID: <1360693342.5128.39.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-02-12 at 11:17 -0700, Stephen Warren wrote:
> On 02/11/2013 11:17 PM, Joe Perches wrote:
> > If the -f pattern is a single file,
> > get_maintainer reads that file content and then
> > matches any K: patterns.
> > 
> > When the -f pattern is a directory, it doesn't.
> 
> Yes, I guess that's true; I had convinced myself that "file" wasn't
> accurate since "-f directory/" didn't scan the files within that
> directory tree, but as you say "-f file" does scan the file content.
> 
> BTW, given I'm adding "filename" to the list, I intend to change the
> existing "file" to "file content" to be clear. Are you OK with that?

Sure.
