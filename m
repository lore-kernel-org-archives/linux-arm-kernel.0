From: dsterba@suse.cz (David Sterba)
Date: Mon, 9 Mar 2015 12:49:14 +0100
Subject: [PATCH] btrfs: fix size_t format string
In-Reply-To: <2448187.keuqSF9F23@wuerfel>
References: <2448187.keuqSF9F23@wuerfel>
Message-ID: <20150309114914.GD5841@twin.jikos.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 12:39:36PM +0100, Arnd Bergmann wrote:
> This warning has been rather annoying because it shows up in every
> 'allmodconfig' build. I assume others have reported it before, but
> please apply some fix for it, ideally before 4.0.

Sorry about that, we're aware of the warning and Chris will push the
patch to the next rc.
