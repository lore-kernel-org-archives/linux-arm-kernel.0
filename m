From: tixy@yxit.co.uk (Tixy)
Date: Mon, 02 May 2011 18:13:04 +0100
Subject: Patch 6853/1 incorrectly moved to superseeded ?
In-Reply-To: <4DBEDD44.7040509@nokia.com>
References: <4DBEDD44.7040509@nokia.com>
Message-ID: <1304356384.5092.32.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-02 at 19:35 +0300, Viktor Rosendahl wrote:
> Hello Russell,
> 
> I got a message that you moved my patch "Patch 6853/1: Fix ldrd/strd 
> emulation for kprobes" to superseeded based on the assumption that it 
> would have been superseeded by John Medhurst's patch "ARM: kprobes: Fix 
> emulation of LDRD and STRD instructions".
> 
> However, when I look at John's patch, it seems to me that his patch is 
> supposed to sit on top of my patch, not to replacing it.
> 
> Nicolas and Tixy, feel free to correct me if I am wrong.

Viktor is correct. My patches were applied on top of his, and both are
required for the code to work correctly.

However, Nicolas put Viktor's patch into his branch together with my
patches, so it may be that the pull from Nicolas' branch will also get
Viltor's patch. Meaning that patch 6853/1 doesn't need to be applied as
well.(?)

-- 
Tixy
