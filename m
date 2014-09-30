From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 30 Sep 2014 16:29:04 -0400
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <cover.1411604443.git.geoff@infradead.org>
References: <cover.1411604443.git.geoff@infradead.org>
Message-ID: <20140930202904.GB24153@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:

[..]
> To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> kexec-tools [2], which have not yet been merged upstream, are needed.
> 
> This series does not include some re-work of the spin-table CPU enable method
> that is needed to support it,

Hi Geoff,

How do I figure out if my system has spin table enable method or psci
enable method. Can one change it. I wanted to test your patches.

Thanks
Vivek
