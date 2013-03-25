From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 10:54:31 +0000
Subject: [PATCH 7/8] ARM: sirf: enable multiplatform support
In-Reply-To: <CAGsJ_4ySCncEh8_03B_CXBuS=h-N=CN5LezVRGoMhME78YPaWg@mail.gmail.com>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
 <1363779679-16880-8-git-send-email-arnd@arndb.de>
 <CAGsJ_4ySCncEh8_03B_CXBuS=h-N=CN5LezVRGoMhME78YPaWg@mail.gmail.com>
Message-ID: <201303251054.31271.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Barry Song wrote:
> will this mean we will don't support "uncompress ..." printed in the
> early uncompress stage before lluart work?

No, with the work that Shawn Guo did, the uncompress code will fall back
to an implementation based on the debug_ll code now, so you still get
the early output.

	Arnd
