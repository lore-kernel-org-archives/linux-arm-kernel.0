From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Mar 2012 09:16:48 +0000
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <4F5579F7.7040603@gmail.com>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201202281945.39419.arnd@arndb.de>
 <alpine.LFD.2.02.1203052035170.31242@xanadu.home>
 <4F5579F7.7040603@gmail.com>
Message-ID: <20120306091648.GD17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 08:44:07PM -0600, Rob Herring wrote:
> So, can we do this for 3.4 or should wait for 3.5?

I'd say wait, otherwise we're going to see delete/modify conflicts
which are a pain to deal with.
