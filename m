From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Nov 2017 18:33:55 +0000
Subject: [PATCH] arm64: fix missing 'const' qualifiers
In-Reply-To: <20171125094127.7536-1-ynorov@caviumnetworks.com>
References: <20171125094127.7536-1-ynorov@caviumnetworks.com>
Message-ID: <20171128183355.GO9266@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 12:41:27PM +0300, Yury Norov wrote:
> It was discovered during LTO-enabled compilation with gcc/ld.bfd.

What was discovered? Could you provide a bit more information in the
changelog, please? I'm happy to take this as a fix if it's actually fixing
something.

Will
