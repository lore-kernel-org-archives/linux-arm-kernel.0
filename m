From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 28 Jan 2010 11:52:14 +0100
Subject: [PATCH/RFC v2 0/3] Human readable platform-specific
	performance event support
In-Reply-To: <1264671263-21412-1-git-send-email-t.fujak@samsung.com>
References: <1264671263-21412-1-git-send-email-t.fujak@samsung.com>
Message-ID: <1264675934.4283.2088.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-28 at 10:34 +0100, Tomasz Fujak wrote:
> Human readable description support for performance events v2. With perf support included.
> Changes from v1:
>  - applied on top of latest perf_event/ARM (5899/1 - 5903/1)
>  - moved to debugfs, now based on seq_file
>  - reads one line at a time, memory overallocation fixed [perf]

You can keep sending these patches, but I'll keep ignoring them
eventually adding you to the /dev/null redirect.
