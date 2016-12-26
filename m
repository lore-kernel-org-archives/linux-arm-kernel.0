From: nm@ti.com (Nishanth Menon)
Date: Mon, 26 Dec 2016 12:56:33 -0600
Subject: v4.10-rc1 - build failure arm64?
In-Reply-To: <20161226184951.GS1555@ZenIV.linux.org.uk>
References: <9e720e28-469f-6a06-a97c-9d52ce951bfb@ti.com>
 <e47e230c-4e76-a7b7-a408-ada809a3b1b8@ti.com>
 <20161226184951.GS1555@ZenIV.linux.org.uk>
Message-ID: <f37bbca1-83f9-508f-2321-0b0887a0e5f2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/26/2016 12:49 PM, Al Viro wrote:
> On Mon, Dec 26, 2016 at 12:46:58PM -0600, Nishanth Menon wrote:
>
>> A bit of bisect later, looks like reverting the following commit allows the
>> build to proceed. -> note: there is no fail on multi_v7_defconfig or
>> omap2plus_defconfig even without the revert.
>
> See git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git#arm64-fix
>
Thanks. [1] does indeed fix the build fail I had noticed.


[1] 
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git/patch/?id=b4b8664d291ac1998e0f0bcdc96b6397f0fe68b3

-- 
Regards,
Nishanth Menon
