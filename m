From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jan 2015 16:55:57 +0000
Subject: [RFC 2/8] ARM64: Refactor kprobes-arm64
In-Reply-To: <9a86c217f387f45568c18b724024b0d3e040d2c6.1420038188.git.panand@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <9a86c217f387f45568c18b724024b0d3e040d2c6.1420038188.git.panand@redhat.com>
Message-ID: <20150108165557.GQ11583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 31, 2014 at 03:21:18PM +0000, Pratyush Anand wrote:
> Most of the stuff of kprobes-arm64.c can also be used by uprobes.c. So
> move all those part to common code area. In the process rename kprobe to
> probe whereever possible.
> 
> No functional change.

In which case, can you merge this into the kprobes series (which we haven't
merged yet)?

Will
