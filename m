From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 29 Aug 2018 13:08:02 +0200
Subject: [PATCH] arm64: add NUMA emulation support
In-Reply-To: <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
Message-ID: <20180829110802.GD10349@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 28-08-18 12:09:53, Shuah Khan wrote:
[...]
> The main intent is to use numa emulation in conjunction with cpusets for coarse
> memory management similar to x86_64 use-case for the same.

Could you be more specific please? Why would you want a hack like this
when you have a full featured memory cgroup controller to limit the
amount of memory?
-- 
Michal Hocko
SUSE Labs
