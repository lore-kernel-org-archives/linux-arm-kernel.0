From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 4 Nov 2015 10:39:58 +0100
Subject: [PATCH v2 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <1446574204-15567-1-git-send-email-dcashman@android.com>
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
Message-ID: <20151104093957.GA31378@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 03-11-15 10:10:03, Daniel Cashman wrote:
[...]
> +This value can be changed after boot using the
> +/proc/sys/kernel/mmap_rnd_bits tunable

Why is this not sitting in /proc/sys/vm/ where we already have
mmap_min_addr. These two sound like they should sit together, no?
-- 
Michal Hocko
SUSE Labs
