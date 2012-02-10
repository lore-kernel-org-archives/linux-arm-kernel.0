From: olof@lixom.net (Olof Johansson)
Date: Thu, 9 Feb 2012 16:25:22 -0800
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20120210105026.0075dcf9eba39eb98e7b44ef@canb.auug.org.au>
References: <20120210105026.0075dcf9eba39eb98e7b44ef@canb.auug.org.au>
Message-ID: <20120210002522.GA15718@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 10:50:26AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-at91/at91cap9.c between commit fa23e771d863 ("Merge branch
> 'fixes' into for-next") from the arm tree and commit 9918ceafd4a9 ("ARM:
> at91: code removal of CAP9 SoC") from the arm-soc tree.
> 
> The latter removes the file, so I did that.

Yep, that's the correct fixup.


Thanks,

-Olof
