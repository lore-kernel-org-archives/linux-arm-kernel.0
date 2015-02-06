From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Feb 2015 00:32:11 -0800
Subject: [PATCH] ARM: sirf: drop redundant function and marco declaration
In-Reply-To: <1422977889-10000-1-git-send-email-21cnbao@gmail.com>
References: <1422977889-10000-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150206083211.GH23582@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 11:38:09PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> with the patchset to add CSR atlas7 support, the below stuff
> has no user now:
> SIRFSOC_VA
> sirfsoc_map_lluart
> sirfsoc_map_scu
> 
> the related patches missed to drop them.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, applied to next/cleanup.


-Olof
