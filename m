From: tytso@MIT.EDU (Theodore Tso)
Date: Thu, 20 Jan 2011 22:41:15 -0500
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <1295576730.4096.24.camel@Joe-Laptop>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
	<AANLkTik+HCj9dkD2s4WgwCqKWCXDbdSnKDUbyGfYfaPr@mail.gmail.com>
	<1295571359.9236.53.camel@m0nster>
	<1295574085.4096.6.camel@Joe-Laptop>
	<1295575123.9236.54.camel@m0nster>
	<1295576730.4096.24.camel@Joe-Laptop>
Message-ID: <C4B33E70-E4B2-4C56-8C53-D9EFA283384D@mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jan 20, 2011, at 9:25 PM, Joe Perches wrote:
> 
> The authors may be different, but the first git
> committer of the patch is different.
> 
> The committer is the person that does a git commit
> either directly with git commit or git am.
> 
> You should keep the original patch author names and
> add your own "Signed-off-by:" and not claim authorship
> of the patches themselves.
> 

For example, many people send me patches for the ext4 tree.

Even if I get the patches from somewhere else, say the SuSE RPM, I will try to determine the author, and use that as the author field in the patches.  If I put a

From: The Original Author <author@original.com>

in the patch before I suck it in using git am, it will use the original author in the Author field.   I will add my Signed-off-by, preserving the other Signed-off-by's, and my name will appear in the Committer field, which is as it should be.

-- Ted
