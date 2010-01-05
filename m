From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 5 Jan 2010 18:57:32 +0000
Subject: [PATCH 3/5] arm: use the spinlocked, generic atomic64 support
In-Reply-To: <1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
Message-ID: <20100105185732.GF14376@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote:
> perf events require that we can support atomic64's. There is a generic,
> spinlocked version that we can use until we have proper hardware
> support.

Is that simply waiting for LDREXD/STREXD-based atomic64's, or is it
depending on something subtler?

-- Jamie
