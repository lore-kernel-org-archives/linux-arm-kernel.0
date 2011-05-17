From: khilman@ti.com (Kevin Hilman)
Date: Tue, 17 May 2011 15:06:43 +0200
Subject: [PATCHv2 0/2] [RFC] Shrink clock data utilizing preprocessor
In-Reply-To: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com> (Vladimir
	Zapolskiy's message of "Mon, 16 May 2011 00:45:56 +0300")
References: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <87r57x4gt8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir Zapolskiy <vzapolskiy@gmail.com> writes:

> This change shows a possibility to utilize C preprocessor to remove
> redundant data from clock definitions for OMAP4 architecture.
>
> If the change is evaluated as a positive one, the same approach could
> be applied in reducing LOCs from other files, which contain monotonous
> data enumeration.

Now that I can apply these patches and look at the result, I still have
the same opinion.  For me, this results in a major loss of readability.

Changes just to make nice diffstats are fine, but not when it impacts
readability, etc.  Especially since this data will likely be eventually
moved to device tree, I'd rather see consolidation efforts focused
elsewhere.

Kevin
