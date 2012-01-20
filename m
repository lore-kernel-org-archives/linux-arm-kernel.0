From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jan 2012 10:34:55 +0000
Subject: [PATCH] ARM: debug: arrange Kconfig options more logically
In-Reply-To: <E1RoB8k-0005HD-RL@rmk-PC.arm.linux.org.uk>
References: <E1RoB8k-0005HD-RL@rmk-PC.arm.linux.org.uk>
Message-ID: <20120120103455.GC23376@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jan 20, 2012 at 09:52:10AM +0000, Russell King - ARM Linux wrote:
> Arrange the Kconfig options in rough alphabetical order, and place the
> default 'none' and 'icedcc' options at the end.  This prefers the
> platform specific debug option rather than the 'none' option, which is
> what we actually want.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig.debug |  156 ++++++++++++++++++++++++------------------------
>  1 files changed, 78 insertions(+), 78 deletions(-)

Looks sensible to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
