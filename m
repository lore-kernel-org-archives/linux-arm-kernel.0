From: arjan@linux.intel.com (Arjan van de Ven)
Date: Thu, 22 Sep 2011 10:35:22 -0700
Subject: [RFC PATCH V6 0/4] cpuidle: Global registration of idle states
	with per-cpu statistics
In-Reply-To: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
References: <20110922082840.10520.85895.stgit@localhost6.localdomain6>
Message-ID: <4E7B71DA.90909@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/22/2011 1:28 AM, Deepthi Dharwar wrote:
> The following patch series implements global registration of cpuidle
> states, and also has the necessary data structure changes to
> accommodate the per-cpu writable members of the cpuidle_states
> structure.
>


you can consider this series Acked-by: Arjan van de Ven 
<arjan@linux.intel.com>
it's a good simplification of the code, and unlike frequencies, idle 
states are really shared between all cpus for
very practical reasons.
