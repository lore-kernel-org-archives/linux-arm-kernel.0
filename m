From: jolsa@redhat.com (Jiri Olsa)
Date: Thu, 8 Feb 2018 14:55:41 +0100
Subject: [PATCH 1/9] perf vendor events: drop incomplete multiple mapfile
 support
In-Reply-To: <1517939104-230881-2-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-2-git-send-email-john.garry@huawei.com>
Message-ID: <20180208135541.GJ10234@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 01:44:56AM +0800, John Garry wrote:
> Currently jevents supports multiple mapfiles, but this
> is only in the form where mapfile basename starts with
> 'mapfile.csv'
> 
> At the moment, no architectures actually use multiple mapfiles,
> so drop the support for now.
> 
> This patch also solves a nuisance where, when the mapfile is
> edited and the text editor may create a backup, jevents may
> use the backup, as shown:
> jevents: Many mapfiles? Using pmu-events/arch/arm64/mapfile.csv~, ignoring pmu-events/arch/arm64/mapfile.csv
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
