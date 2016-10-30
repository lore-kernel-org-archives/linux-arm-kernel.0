From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 30 Oct 2016 14:22:46 +0000
Subject: [PATCH v7 REPOST 0/9] CPUs capacity information for
 heterogeneous systems
In-Reply-To: <20161017154650.18779-1-juri.lelli@arm.com>
References: <20161017154650.18779-1-juri.lelli@arm.com>
Message-ID: <20161030142246.od5skjzegyp62hma@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 04:46:41PM +0100, Juri Lelli wrote:
> I'm thus now assuming that everybody is OK with the patches and that they can
> be queued for 4.10 (we certainly need this plumbing at this point). Please
> speak if my assumption is wrong (and provide feedback! :).
> Otherwise I'm going to:
> 
>  - use Russell's patching system for patches 2 and 8
>  - ask Sudeep to pull patches 3,5,6 and 7
>  - ask Catalin/Will to pull patches 1,4 and 9

I'm happy to queue patches 1, 4 and 9 for 4.10 (though it might have
been easier for the whole series to go through arm-soc).

> Do you think we might get into trouble splitting the merge process this way?

Probably not. The only minor downside is that I have to grab a new DT
for Juno from Sudeep to test the patches. Not an issue, though.

-- 
Catalin
