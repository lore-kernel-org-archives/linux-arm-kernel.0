From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 23 Oct 2018 13:32:34 +0200
Subject: [PATCH v2 1/7] modules: Create rlimit for module space
In-Reply-To: <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com>
 <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
 <7b0714e26c7c2216721641d7df16a49687927e37.camel@intel.com>
Message-ID: <20181023113234.GH32333@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 12-10-18 17:04:46, Edgecombe, Rick P wrote:
[...]
> Any thoughts on if instead of all this there was just a system wide limit on BPF
> JIT module space usage?

We do allow to charge vmalloc memory to a memory cgroup. Isn't that a
way forward?
-- 
Michal Hocko
SUSE Labs
